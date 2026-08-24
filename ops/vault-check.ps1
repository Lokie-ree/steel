# ops/vault-check.ps1 — integrity check on the hub's own memory layer.
#
# drift-check.ps1 asks whether the frozen spokes still agree with each other.
# This asks whether the vault's own records still resolve. Deliberately a separate
# script with a separate verdict: folding it into drift-check would produce one
# green line covering two unrelated questions, which is the failure CLAUDE.md
# already warns about — "a drift PASS says nothing about course-lab."
#
# Every check below was written from a defect that actually happened, not from a
# hypothetical:
#   1. dangling links   — a relative wikilink left broken by the ops/claude.md ->
#                         CLAUDE.md move (2026-07-31), found 2026-08-23; four more
#                         orphaned the same week by archiving a sprint.
#   2. bare-date cites  — 19 citations pointing at a date carrying 2-3 rulings.
#   3. unknown IDs      — a typo in a ruling ID resolves to nothing and says nothing.
#   4. index vs log     — decisions.md now summarises itself; the two can drift.
#   5. doc paths        — a backticked plan path that resolves to no file.
#   6. amended rulings  — informational: a citation of a ruling whose scope moved.
#
# NOT SCANNED, and why:
#   .claude/ .agents/            vendored skills, full of [[Note Name]] syntax examples
#   ops/tests/fixtures/          deliberately fake data
#   docs/superpowers/{plans,specs}/  executed plans are frozen historical record
#                                (CLAUDE.md §Documentation) and their relative links
#                                resolve against the spoke they ran in, not here.
#
# Exit: 0 clean · 1 failures.  -SelfTest runs the resolver's own assertions.

[CmdletBinding()]
param([switch]$SelfTest)

$vault = Split-Path $PSScriptRoot -Parent

# ---------------------------------------------------------------- pure helpers
function Remove-CodeSpans {
    # A [[link]] inside a code fence or backticks is an example of syntax, not a
    # link — README's `[[wikilinks]]`, sanity-ai-portfolio's `[[...tool]]` route.
    param([string]$Text)
    $t = [regex]::Replace($Text, '(?s)```.*?```', '')
    [regex]::Replace($t, '`[^`\r\n]*`', '')
}

function Resolve-VaultLink {
    # Relative to the citing file first; fall back to a unique basename, which is
    # how Obsidian itself resolves a bare [[stem]]. An ambiguous stem is a miss.
    param([string]$FromFile, [string]$Target, [hashtable]$Files, [hashtable]$ByStem)
    $t = $Target.Trim()
    if (-not $t.EndsWith('.md')) { $t = "$t.md" }
    $abs = [System.IO.Path]::GetFullPath((Join-Path (Split-Path $FromFile -Parent) $t))
    if ($Files.ContainsKey($abs)) { return $abs }
    $stem = [System.IO.Path]::GetFileNameWithoutExtension($t).ToLower()
    if ($ByStem.ContainsKey($stem) -and $ByStem[$stem].Count -eq 1) { return $ByStem[$stem][0] }
    return $null
}

# ------------------------------------------------------------------- self test
if ($SelfTest) {
    $tmp = Join-Path ([System.IO.Path]::GetTempPath()) "vault-check-selftest-$PID"
    New-Item -ItemType Directory -Path (Join-Path $tmp 'wiki') -Force | Out-Null
    'x' | Set-Content (Join-Path $tmp 'wiki/decisions.md')
    'x' | Set-Content (Join-Path $tmp 'CLAUDE.md')
    $files  = @{}; $byStem = @{}
    Get-ChildItem $tmp -Recurse -Filter *.md | ForEach-Object {
        $files[$_.FullName] = $true
        $s = $_.BaseName.ToLower()
        if (-not $byStem.ContainsKey($s)) { $byStem[$s] = @() }
        $byStem[$s] += $_.FullName
    }
    $root = Join-Path $tmp 'CLAUDE.md'; $deep = Join-Path $tmp 'wiki/decisions.md'
    $t = 0; $bad = 0
    function A($cond, $name) { $script:t++; if (-not $cond) { $script:bad++; Write-Host "  FAIL  $name" -ForegroundColor Red } else { Write-Host "  ok    $name" -ForegroundColor DarkGray } }

    A ((Resolve-VaultLink $root 'wiki/decisions' $files $byStem) -eq $deep)      'relative down resolves'
    A ((Resolve-VaultLink $deep '../CLAUDE'      $files $byStem) -eq $root)      'relative up resolves'
    A ((Resolve-VaultLink $deep 'decisions'      $files $byStem) -eq $deep)      'bare stem resolves'
    A ((Resolve-VaultLink $root '../../escape'   $files $byStem) -eq $null)      'outside the vault is a miss'
    A ((Resolve-VaultLink $deep '../wiki/nope'   $files $byStem) -eq $null)      'missing file is a miss'
    A ((Remove-CodeSpans 'see `[[wikilinks]]` ok') -notmatch '\[\[')             'inline code stripped'
    A ((Remove-CodeSpans "a`n```````n[[X]]`n```````nb") -notmatch '\[\[')        'fenced block stripped'
    A ((Remove-CodeSpans 'real [[decisions]] link') -match '\[\[decisions\]\]')  'real link survives'

    Remove-Item $tmp -Recurse -Force
    Write-Host "`n  self-test: $($t - $bad)/$t" -ForegroundColor $(if ($bad) { 'Red' } else { 'Green' })
    exit $(if ($bad) { 1 } else { 0 })
}

# ------------------------------------------------------------------- inventory
$skip = @('\.git\', '\node_modules\', '\.claude\', '\.agents\',
          '\ops\tests\fixtures\', '\docs\superpowers\plans\', '\docs\superpowers\specs\')
$all = Get-ChildItem $vault -Recurse -Filter *.md -File |
       Where-Object { $p = $_.FullName; -not ($skip | Where-Object { $p -like "*$_*" }) }

$files = @{}; $byStem = @{}
Get-ChildItem $vault -Recurse -Filter *.md -File |
    Where-Object { $_.FullName -notlike '*\.git\*' -and $_.FullName -notlike '*\node_modules\*' } |
    ForEach-Object {
        $files[$_.FullName] = $true
        $s = $_.BaseName.ToLower()
        if (-not $byStem.ContainsKey($s)) { $byStem[$s] = @() }
        $byStem[$s] += $_.FullName
    }

$fail = 0; $issues = @(); $notes = @()
function Fail($msg) { $script:fail++; $script:issues += "  - $msg" }
function Section($t) { Write-Host "`n$t" -ForegroundColor Cyan }

# --------------------------------------------------- 1. dangling wikilinks
Section 'Link integrity'
$linkCount = 0
foreach ($f in $all) {
    $body = Remove-CodeSpans (Get-Content $f.FullName -Raw)
    foreach ($m in [regex]::Matches($body, '\[\[([^\]\|#]+)(?:[#\|][^\]]*)?\]\]')) {
        $linkCount++
        if (-not (Resolve-VaultLink $f.FullName $m.Groups[1].Value $files $byStem)) {
            Fail "dangling link: $($f.FullName.Substring($vault.Length+1)) -> [[$($m.Groups[1].Value)]]"
        }
    }
}
Write-Host "  $linkCount wikilinks resolved" -ForegroundColor $(if ($fail) { 'Red' } else { 'Green' })

# ------------------------------------- 2-4. decisions log: IDs, index, citations
Section 'Decisions log'
$decPath = Join-Path $vault 'wiki/decisions.md'
$lines = Get-Content $decPath
$inIndex = $false; $inLog = $false; $idxIds = @(); $logIds = @(); $status = @{}
foreach ($l in $lines) {
    if ($l -match '^##\s+Ruling index') { $inIndex = $true;  $inLog = $false; continue }
    if ($l -match '^##\s+The log')      { $inIndex = $false; $inLog = $true;  continue }
    if ($l -notmatch '^\|\s*\*\*(D-\d{4}-\d{2}-\d{2}[a-z]?)\*\*') { continue }
    $id = $Matches[1]
    if ($inIndex) { $idxIds += $id }
    elseif ($inLog) {
        $logIds += $id
        $cells = $l -split '\|'
        $status[$id] = $cells[5].Trim() -replace '\*', ''
    }
}
if ($logIds.Count -eq 0) { Fail 'decisions.md: no ruling rows parsed — the table shape changed' }
if (($idxIds -join ',') -ne ($logIds -join ',')) {
    Fail "decisions.md: ruling index and log disagree (index $($idxIds.Count), log $($logIds.Count))"
}
if (($logIds | Sort-Object -Unique).Count -ne $logIds.Count) { Fail 'decisions.md: duplicate ruling ID' }
Write-Host "  $($logIds.Count) rulings, index in agreement" -ForegroundColor Green

$known = @{}; $logIds | ForEach-Object { $known[$_] = $true }
$bare = 0; $unknown = 0; $amendedCites = 0
foreach ($f in $all) {
    if ($f.FullName -eq $decPath) { continue }
    $n = 0
    foreach ($l in (Get-Content $f.FullName)) {
        $n++
        foreach ($m in [regex]::Matches($l, '\[\[[^\]]*decisions[^\]]*\]\]\s*(D-)?(\d{4}-\d{2}-\d{2})([a-z]?)')) {
            $rel = $f.FullName.Substring($vault.Length + 1)
            if (-not $m.Groups[1].Success) {
                $bare++; Fail "bare-date citation (cite by ID): ${rel}:$n -> $($m.Groups[2].Value)"
                continue
            }
            $id = 'D-' + $m.Groups[2].Value + $m.Groups[3].Value
            if (-not $known.ContainsKey($id)) { $unknown++; Fail "unknown ruling ID: ${rel}:$n -> $id" }
            elseif ($status[$id] -ne 'active') { $amendedCites++; $notes += "  - ${rel}:$n cites $id ($($status[$id]))" }
        }
    }
}
Write-Host "  citations: $bare bare-date, $unknown unknown ID" -ForegroundColor $(if ($bare + $unknown) { 'Red' } else { 'Green' })

# ------------------------------------------------- 5. steel-relative doc paths
Section 'Plan & spec paths'
$pathMiss = 0; $pathSeen = 0
foreach ($f in $all) {
    foreach ($m in [regex]::Matches((Get-Content $f.FullName -Raw), '`([^`]*docs/superpowers/[^`]*\.md)`')) {
        $p = $m.Groups[1].Value
        # a spoke-prefixed path is that spoke's copy and is not ours to resolve
        if ($p -notlike 'docs/superpowers/*') { continue }
        $pathSeen++
        if (-not (Test-Path (Join-Path $vault $p))) {
            $pathMiss++; Fail "backticked path resolves to nothing: $($f.FullName.Substring($vault.Length+1)) -> $p"
        }
    }
}
Write-Host "  $pathSeen steel-relative plan/spec paths, $pathMiss unresolved" -ForegroundColor $(if ($pathMiss) { 'Red' } else { 'Green' })

# ---------------------------------------------------------------------- verdict
Write-Host "`n─────────────────────────────" -ForegroundColor DarkGray
if ($notes) {
    Write-Host "  NOTICE — citations of a ruling whose scope moved (not a failure):" -ForegroundColor Yellow
    $notes | ForEach-Object { Write-Host $_ -ForegroundColor DarkYellow }
    Write-Host ''
}
if ($fail) {
    Write-Host "  $fail problem$(if ($fail -ne 1) {'s'})" -ForegroundColor Red
    $issues | ForEach-Object { Write-Host $_ -ForegroundColor Red }
    Write-Host "`n  VERDICT: the vault's own records do not resolve." -ForegroundColor Red
    exit 1
}
Write-Host "  vault records resolve — links, ruling IDs, plan paths" -ForegroundColor Green
Write-Host "  Note: says nothing about the spokes — that is drift-check.ps1." -ForegroundColor DarkGray
