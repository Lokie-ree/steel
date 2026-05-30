# ops/repo-state.ps1  — read-only git preflight across all spokes.
# Fetches (read-only) and reports branch/ahead/behind/dirty. Never pulls or writes.
# Exit code = number of spokes that are behind origin, dirty, or unfetchable.
Import-Module "$PSScriptRoot/lib/HubContext.psm1" -Force

$vault  = Split-Path $PSScriptRoot -Parent
$spokes = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')

$problems = 0
$results  = @()
foreach ($name in $spokes.Keys) {
    $path = $spokes[$name]
    if (-not (Test-Path $path)) { Write-Host "  SKIP  $name (not found: $path)" -ForegroundColor DarkYellow; continue }
    git -C $path fetch --quiet 2>$null
    $fetchOk = $LASTEXITCODE -eq 0
    $porc = @(git -C $path status -sb 2>$null)
    $st = ConvertFrom-GitStatus -Porcelain $porc
    $st['repo'] = $name; $st['fetched'] = $fetchOk
    $results += [pscustomobject]$st
    if ($st.behind -gt 0 -or $st.dirty -or -not $fetchOk) { $problems++ }
}

$results | Format-Table repo, branch, ahead, behind, dirty, fetched -AutoSize | Out-String | Write-Host
if (($results | Where-Object { -not $_.fetched }).Count -gt 0) {
    Write-Host "  NOTE: some repos could not fetch (offline?) — comparisons are local-only." -ForegroundColor DarkYellow
}
$global:RepoState = $results
exit $problems
