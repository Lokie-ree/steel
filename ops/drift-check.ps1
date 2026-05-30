# drift-check.ps1
# Tier 1 sync scan across all four spoke repos.
# Run from anywhere: pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\drift-check.ps1

$base = "C:\Users\rplap\OneDrive\Desktop\personal"
$pass = 0
$fail = 0
$issues = @()

function Check {
    param(
        [string]$label,
        [string]$file,
        [string]$pattern
    )
    if (-not (Test-Path $file)) {
        Write-Host "  SKIP  $label  (file not found: $file)" -ForegroundColor DarkYellow
        return
    }
    $hit = Select-String -Path $file -Pattern $pattern -Quiet
    if ($hit) {
        Write-Host "  PASS  $label" -ForegroundColor Green
        $script:pass++
    } else {
        Write-Host "  FAIL  $label" -ForegroundColor Red
        $script:fail++
        $script:issues += "  - $label`n    file: $file`n    pattern: $pattern"
    }
}

# ─── files ────────────────────────────────────────────────────────────────────
$clModules   = "$base\creative-lab\src\config\modules.ts"
$portApp     = "$base\portfolio\src\App.tsx"
$isteRM      = "$base\iste-26\src\components\lab-guides\RigidMotions.tsx"
$isteDil     = "$base\iste-26\src\components\lab-guides\Dilations.tsx"
$istePyth    = "$base\iste-26\src\components\lab-guides\PythagoreanTheorem.tsx"
$isteApp     = "$base\iste-26\src\App.tsx"

# ─── module names ─────────────────────────────────────────────────────────────
Write-Host "`nModule display names" -ForegroundColor Cyan

Check "Rigid Motions — creative-lab modules.ts"        $clModules  "Rigid Motions"
Check "Rigid Motions — portfolio App.tsx"              $portApp    "Rigid Motions"
Check "Rigid Motions — iste-26 RigidMotions.tsx"       $isteRM     "Rigid Motions"

Check "Dilations & Similarity — creative-lab modules.ts" $clModules "Dilations & Similarity"
Check "Dilations & Similarity — portfolio App.tsx"       $portApp   "Dilations & Similarity"
Check "Dilations & Similarity — iste-26 Dilations.tsx"   $isteDil   "Dilations & Similarity"

Check "Pythagorean Theorem — creative-lab modules.ts"    $clModules "Pythagorean Theorem"
Check "Pythagorean Theorem — portfolio App.tsx"          $portApp   "Pythagorean Theorem"
Check "Pythagorean Theorem — iste-26 PythagoreanTheorem.tsx" $istePyth "Pythagorean Theorem"

# ─── standards strings ────────────────────────────────────────────────────────
Write-Host "`nStandards strings" -ForegroundColor Cyan

Check "8.G.A.1–3 — portfolio App.tsx"   $portApp  "8\.G\.A\.1"
Check "8.G.A.3–5 — portfolio App.tsx"   $portApp  "8\.G\.A\.3"
Check "8.G.B.6–8 — portfolio App.tsx"   $portApp  "8\.G\.B\.6"

Check "8.G.A.1 — iste-26 RigidMotions"  $isteRM   "8\.G\.A\.1"
Check "8.G.A.3 — iste-26 Dilations"     $isteDil  "8\.G\.A\.3"
Check "8.G.B.7 — iste-26 Pythagorean"   $istePyth "8\.G\.B\.7"

# ─── ISTE event string ────────────────────────────────────────────────────────
Write-Host "`nISTE event string" -ForegroundColor Cyan

Check "ISTE LIVE 2026 — RigidMotions.tsx"      $isteRM   "ISTE LIVE 2026"
Check "ISTE LIVE 2026 — Dilations.tsx"         $isteDil  "ISTE LIVE 2026"
Check "ISTE LIVE 2026 — PythagoreanTheorem.tsx" $istePyth "ISTE LIVE 2026"

# ─── deploy URLs ──────────────────────────────────────────────────────────────
Write-Host "`nDeploy URLs" -ForegroundColor Cyan

Check "creative-lab URL — iste-26 RigidMotions"      $isteRM   "creative-lab-five\.vercel\.app"
Check "creative-lab URL — iste-26 Dilations"         $isteDil  "creative-lab-five\.vercel\.app"
Check "creative-lab URL — iste-26 Pythagorean"       $istePyth "creative-lab-five\.vercel\.app"
Check "creative-lab URL — portfolio App.tsx"         $portApp  "creative-lab-five\.vercel\.app"

Check "iste-26 #dilations href — portfolio App.tsx"            $portApp "iste-26\.vercel\.app.*#dilations"
Check "iste-26 #pythagorean-theorem href — portfolio App.tsx"  $portApp "iste-26\.vercel\.app.*#pythagorean-theorem"

# ─── hash routes ──────────────────────────────────────────────────────────────
Write-Host "`nHash routes (iste-26 App.tsx)" -ForegroundColor Cyan

Check "rigid-motions route defined"       $isteApp "rigid-motions"
Check "dilations route defined"           $isteApp "dilations"
Check "pythagorean-theorem route defined" $isteApp "pythagorean-theorem"

# ─── summary ──────────────────────────────────────────────────────────────────
Write-Host "`n─────────────────────────────────────────" -ForegroundColor DarkGray
Write-Host "  $pass passed  |  $fail failed" -ForegroundColor $(if ($fail -gt 0) { "Red" } else { "Green" })

if ($issues.Count -gt 0) {
    Write-Host "`nFailing checks:" -ForegroundColor Red
    $issues | ForEach-Object { Write-Host $_ }
}

Write-Host ""
