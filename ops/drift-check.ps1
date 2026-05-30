# ops/drift-check.ps1 — two-stage drift validation against canonical module-facts.
# Stage 1: each spoke's .hub bundle hash == vault canonical hash (freshness).
# Stage 2: each spoke's source contains the canonical values (conformance, cross-references only).
# Refuses a PASS verdict if any spoke is behind origin (reading stale local code is not trustworthy).
Import-Module "$PSScriptRoot/lib/HubContext.psm1" -Force
$vault   = Split-Path $PSScriptRoot -Parent
$factsMd = Join-Path $vault 'wiki/module-facts.md'
$spokes  = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')
$base    = Split-Path $spokes.'creative-lab' -Parent   # repo-internal file paths below are drift-check-specific

# 0. Preflight — refuse a PASS verdict if any repo is behind origin / dirty
& "$PSScriptRoot/repo-state.ps1" | Out-Null
$stale = $LASTEXITCODE -ne 0

# Canonical truth
$raw     = Get-Content -LiteralPath $factsMd -Raw
$facts   = ConvertFrom-ModuleFacts -Path $factsMd
$canHash = Get-SourceHash -Text $raw

$pass = 0; $fail = 0; $issues = @()
function Check($label, $file, $pattern) {
    if (-not (Test-Path $file)) { Write-Host "  SKIP  $label" -ForegroundColor DarkYellow; return }
    if (Select-String -Path $file -Pattern $pattern -Quiet) {
        Write-Host "  PASS  $label" -ForegroundColor Green; $script:pass++
    } else {
        Write-Host "  FAIL  $label" -ForegroundColor Red; $script:fail++
        $script:issues += "  - $label`n      file: $file`n      expected: $pattern"
    }
}

# Stage 1 — bundle freshness
Write-Host "`nStage 1 — bundle freshness" -ForegroundColor Cyan
foreach ($name in $spokes.Keys) {
    $jf = Join-Path $spokes[$name] '.hub/module-facts.json'
    if (-not (Test-Path $jf)) { Write-Host "  SKIP  $name (.hub not installed)" -ForegroundColor DarkYellow; continue }
    $rh = (Get-Content $jf -Raw | ConvertFrom-Json)._generated.sourceHash
    if ($rh -eq $canHash) { Write-Host "  PASS  $name bundle current" -ForegroundColor Green; $script:pass++ }
    else { Write-Host "  FAIL  $name bundle STALE (regenerate)" -ForegroundColor Red; $script:fail++; $script:issues += "  - $name .hub stale: run ops/build-context.ps1 + commit" }
}

# Stage 2 — code conformance (cross-references only; a site never hardcodes its own origin)
Write-Host "`nStage 2 — code conformance" -ForegroundColor Cyan
$clModules = "$base/creative-lab/src/config/modules.ts"
$portApp   = "$base/portfolio/src/App.tsx"
$isteApp   = "$base/iste-26/src/App.tsx"
$guide = @{
    M1 = "$base/iste-26/src/components/lab-guides/RigidMotions.tsx"
    M2 = "$base/iste-26/src/components/lab-guides/Dilations.tsx"
    M3 = "$base/iste-26/src/components/lab-guides/PythagoreanTheorem.tsx"
}
foreach ($m in $facts.modules) {
    $name = [regex]::Escape($m.displayName); $std = [regex]::Escape(($m.standards -split '-')[0])
    Check "$($m.id) name — creative-lab"       $clModules    $name
    Check "$($m.id) name — portfolio"          $portApp      $name
    Check "$($m.id) name — iste-26 guide"      $guide[$m.id] $name
    Check "$($m.id) standards — iste-26 guide" $guide[$m.id] $std
    Check "$($m.id) hash route — iste-26 App"  $isteApp ([regex]::Escape($m.iste26Hash.TrimStart('#')))
}
# Match the bare domain (scheme-optional): source references appear both as
# https://creative-lab-five.vercel.app (portfolio) and creative-lab-five.vercel.app (iste guides).
$clUrl = [regex]::Escape(($facts.deployUrls.'creative-lab' -replace '^https?://',''))
Check "creative-lab URL — portfolio" $portApp $clUrl
foreach ($id in 'M1','M2','M3') { Check "creative-lab URL — iste-26 $id guide" $guide[$id] $clUrl }
Check "iste-26 #dilations href — portfolio"           $portApp 'iste-26\.vercel\.app.*#dilations'
Check "iste-26 #pythagorean-theorem href — portfolio" $portApp 'iste-26\.vercel\.app.*#pythagorean-theorem'
Check "event name — iste-26 RigidMotions" $guide.M1 ([regex]::Escape($facts.event.name))

# Summary
Write-Host "`n─────────────────────────────" -ForegroundColor DarkGray
Write-Host "  $pass passed | $fail failed" -ForegroundColor $(if ($fail) { 'Red' } else { 'Green' })
if ($issues) { Write-Host "`nFailures:" -ForegroundColor Red; $issues | ForEach-Object { Write-Host $_ } }
if ($stale)   { Write-Host "`n  VERDICT: UNVERIFIED — a spoke is behind origin or dirty. Pull, then re-run. Not a PASS." -ForegroundColor Yellow; exit 2 }
elseif ($fail) { exit 1 } else { Write-Host "`n  VERDICT: all Tier 1 fields aligned." -ForegroundColor Green }
