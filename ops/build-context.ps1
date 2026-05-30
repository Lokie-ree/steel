# ops/build-context.ps1 — generate the .hub/ bundle into each spoke (vault -> repos, one direction).
# Writes <spoke>/.hub/module-facts.json (identical everywhere) + <spoke>/.hub/context.md (per-repo).
# Run when wiki/module-facts.md changes. Does NOT commit inside spokes — that's the operator's step.
param([switch]$Force)   # -Force skips the behind/dirty stop-and-ask
Import-Module "$PSScriptRoot/lib/HubContext.psm1" -Force

$vault   = Split-Path $PSScriptRoot -Parent
$factsMd = Join-Path $vault 'wiki/module-facts.md'
$spokes  = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')

# 1. Preflight (fail closed unless -Force)
& "$PSScriptRoot/repo-state.ps1" | Out-Null
if ($LASTEXITCODE -ne 0 -and -not $Force) {
    Write-Host "Some spokes are behind/dirty. Pull first, or re-run with -Force." -ForegroundColor Red
    exit 1
}

# 2. Parse + hash (fail closed on parse error)
$raw   = Get-Content -LiteralPath $factsMd -Raw
$facts = ConvertFrom-ModuleFacts -Path $factsMd
if ($facts.modules.Count -ne 3) {
    Write-Host "Parse error: expected 3 modules, got $($facts.modules.Count). Aborting — no bundles written." -ForegroundColor Red
    exit 1
}
$hash  = Get-SourceHash -Text $raw
$json  = Format-ModuleFactsJson -Facts $facts -SourceHash $hash

# 3. Per-repo role block (from projects/<repo>.md ## Role) + universal vision
$visionLines = @(
    'Manipulation before explanation','Earned reveal of formal notation','Matching IS verification',
    'Same scalene triangle carries M2 → M3',
    'creative-lab wins on behavior · iste-26 on teacher notes · portfolio on narrative'
)
function Get-RoleBlock([string]$repo) {
    $card = Join-Path $vault "projects/$repo.md"
    if (-not (Test-Path $card)) { return "(no project card found)" }
    $lines = Get-Content $card; $out = @(); $in = $false
    foreach ($l in $lines) {
        if ($l -match '^##\s') { if ($in) { break }; $in = ($l -match '##\s+Role'); continue }
        if ($in -and $l.Trim()) { $out += $l.Trim() }
    }
    return ($out -join "`n")
}

# 4. Write bundles
foreach ($name in $spokes.Keys) {
    $path = $spokes[$name]; if (-not (Test-Path $path)) { Write-Host "  SKIP  $name"; continue }
    $hubDir = Join-Path $path '.hub'
    New-Item -ItemType Directory -Force -Path $hubDir | Out-Null
    Set-Content -LiteralPath (Join-Path $hubDir 'module-facts.json') -Value $json -Encoding utf8 -NoNewline
    $ctx = Format-ContextMarkdown -Repo $name -RoleBlock (Get-RoleBlock $name) -VisionLines $visionLines
    Set-Content -LiteralPath (Join-Path $hubDir 'context.md') -Value $ctx -Encoding utf8
    Write-Host "  wrote  $name/.hub/  (review: git -C $path diff --stat .hub)" -ForegroundColor Green
}
Write-Host "`nDone. Review each repo's .hub/ diff, then commit it in that repo." -ForegroundColor Cyan
