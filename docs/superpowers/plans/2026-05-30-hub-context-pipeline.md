# Hub Context Pipeline Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `steel` generate a canonical facts/vision bundle one-directionally into each of the four spoke repos, and rewrite drift-check to validate every repo against that one artifact behind a git-state preflight.

**Architecture:** Pure logic (parse `module-facts.md`, hash, render JSON/markdown, compare) lives in a testable module `ops/lib/HubContext.psm1`. Three thin orchestrator scripts (`repo-state.ps1`, `build-context.ps1`, `drift-check.ps1`) wire that logic to git and the filesystem. Pure functions are TDD'd with Pester; the IO orchestrators get scripted integration verification.

**Tech Stack:** PowerShell 7.6, Pester 5.x (test framework), git 2.47. No repo code changes required for drift-check to work (Stage 2 validates source strings).

**Spec:** `docs/superpowers/specs/2026-05-30-hub-context-pipeline-design.md`

> **✓ M1 coordinate discrepancy — RESOLVED (2026-05-30).** Operator confirmed the rigid-motions
> triangle constant is `A(−3,−2) B(1,−1) C(−2,1)` — exactly what `wiki/module-facts.md` already says,
> so the canonical file is **correct, no change needed**. The `[[1,1],[4,2],[2,4]]` seen earlier was
> test-fixture data in `rigid-motions/scene/__tests__/animations.test.ts`, not the module's triangle.

---

## File Structure

| File | Responsibility |
|------|----------------|
| `ops/lib/HubContext.psm1` | Pure functions: parse module-facts, source hash, render JSON, render context.md, compare freshness. No git, no console. |
| `ops/repo-state.ps1` | Git preflight: fetch + report ahead/behind/dirty per spoke. Read-only. |
| `ops/build-context.ps1` | Generator orchestrator: preflight → parse → write `.hub/` into each spoke. |
| `ops/drift-check.ps1` | Validator orchestrator (rewrite): preflight → Stage 1 freshness → Stage 2 conformance. |
| `ops/tests/HubContext.Tests.ps1` | Pester tests for the pure functions. |
| `ops/tests/fixtures/` | Sample `module-facts.md` + a fake spoke tree for tests. |
| `wiki/module-facts.md` | MODIFY: add canonical event string (closes the gap the spec flagged). |
| `.claude/skills/drift-check/SKILL.md` | MODIFY: two-stage + preflight wording. |
| `.claude/skills/session-start/SKILL.md` | MODIFY: add repo-state line to briefing. |
| `.claude/skills/build-context/SKILL.md` | CREATE: thin "regenerate the bundle" skill. |

Spoke paths (authoritative source = "Local paths" table in `index.md`):
- creative-lab `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab`
- iste-26 `C:/Users/rplap/OneDrive/Desktop/personal/iste-26`
- portfolio `C:/Users/rplap/OneDrive/Desktop/personal/portfolio`
- creative-lab-demos `C:/Users/rplap/OneDrive/Desktop/personal/creative-lab-demos`

---

## Task 0: Baseline — git init + Pester 5

**Files:**
- Create: `.gitignore`

- [ ] **Step 1: Initialize the vault as a local git repo**

```powershell
cd C:\Users\rplap\OneDrive\Desktop\steel
git init
git add -A
git commit -m "chore: baseline before hub context pipeline"
```

(GitHub remote + push is deferred to the final task — the "good stopping point.")

- [ ] **Step 2: Add a .gitignore**

```
# .gitignore
ops/tests/.tmp/
*.log
```

- [ ] **Step 3: Ensure Pester 5 is available (CurrentUser scope, no admin)**

```powershell
if (-not (Get-Module -ListAvailable Pester | Where-Object Version -ge '5.0.0')) {
    Install-Module Pester -MinimumVersion 5.0.0 -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module Pester -MinimumVersion 5.0.0
(Get-Module Pester).Version.ToString()
```

Expected: prints `5.x.x`. If offline and install fails, surface to the operator — do not proceed.

- [ ] **Step 4: Commit**

```powershell
git add .gitignore
git commit -m "chore: add gitignore and confirm Pester 5"
```

---

## Task 1: Add canonical event string to module-facts.md

**Files:**
- Modify: `wiki/module-facts.md`

The full event string `Orlando · June 28 – July 1, 2026` is not yet in the canonical file (only `ISTE LIVE 2026` exists implicitly). Add it so the generator parses it instead of hardcoding.

- [ ] **Step 1: Add an Event section** after the title, before "## Grade 8 Geometry arc":

```markdown
## Event

| Field | Value |
|-------|-------|
| Name | ISTE LIVE 2026 |
| Full string | Orlando · June 28 – July 1, 2026 |
```

- [ ] **Step 2: Commit**

```powershell
git add wiki/module-facts.md
git commit -m "data: add canonical ISTE event string to module-facts"
```

---

## Task 2: HubContext module scaffold + parse modules (TDD)

**Files:**
- Create: `ops/lib/HubContext.psm1`
- Create: `ops/tests/HubContext.Tests.ps1`
- Create: `ops/tests/fixtures/module-facts.md` (copy of real file at time of writing)

- [ ] **Step 1: Create the fixture** — copy the current `wiki/module-facts.md` into `ops/tests/fixtures/module-facts.md` (after Task 1, so it includes the Event section). This is the parser's test input.

- [ ] **Step 2: Write the failing test**

```powershell
# ops/tests/HubContext.Tests.ps1
BeforeAll {
    Import-Module "$PSScriptRoot/../lib/HubContext.psm1" -Force
    $script:fixture = "$PSScriptRoot/fixtures/module-facts.md"
}

Describe "ConvertFrom-ModuleFacts" {
    BeforeAll { $script:facts = ConvertFrom-ModuleFacts -Path $script:fixture }

    It "parses three modules" {
        $script:facts.modules.Count | Should -Be 3
    }
    It "reads M1 display name and standards" {
        $m1 = $script:facts.modules | Where-Object id -eq 'M1'
        $m1.displayName | Should -Be 'Rigid Motions'
        $m1.standards   | Should -Be '8.G.A.1-3'   # en-dash normalized to hyphen
    }
    It "normalizes Unicode minus in triangle coords to ASCII integers" {
        $m1 = $script:facts.modules | Where-Object id -eq 'M1'
        $m1.triangle.A | Should -Be @(-3,-2)
        $m1.triangle.B | Should -Be @(1,-1)
        $m1.triangle.C | Should -Be @(-2,1)
    }
    It "treats M2 and M3 as sharing the same triangle" {
        $m2 = $script:facts.modules | Where-Object id -eq 'M2'
        $m3 = $script:facts.modules | Where-Object id -eq 'M3'
        ($m2.triangle | ConvertTo-Json) | Should -Be ($m3.triangle | ConvertTo-Json)
    }
    It "extracts creative-lab module slug and iste-26 hash" {
        $m1 = $script:facts.modules | Where-Object id -eq 'M1'
        $m1.creativeLabModule | Should -Be 'rigid-motions'
        $m1.iste26Hash        | Should -Be '#rigid-motions'
    }
    It "reads deploy URLs and the event string" {
        $script:facts.deployUrls.'creative-lab' | Should -Be 'https://creative-lab-five.vercel.app'
        $script:facts.event.string | Should -Be 'Orlando · June 28 – July 1, 2026'
        $script:facts.event.name   | Should -Be 'ISTE LIVE 2026'
    }
}
```

- [ ] **Step 3: Run it to verify it fails**

Run: `Invoke-Pester ops/tests/HubContext.Tests.ps1`
Expected: FAIL — `ConvertFrom-ModuleFacts` not recognized.

- [ ] **Step 4: Implement `ConvertFrom-ModuleFacts`**

```powershell
# ops/lib/HubContext.psm1

function ConvertTo-AsciiDashes {
    param([string]$s)
    # U+2212 minus, U+2013 en-dash, U+2014 em-dash -> ASCII hyphen
    return ($s -replace "[−–—]", '-')
}

function Get-MarkdownTableRows {
    # returns arrays of trimmed cell values for each data row of the first
    # pipe-table found after a line matching $afterHeading
    param([string[]]$Lines, [string]$AfterHeading)
    $rows = @()
    $inSection = $false; $seenHeader = $false
    foreach ($line in $Lines) {
        if ($line -match "^#+\s") { if ($inSection) { break }; $inSection = ($line -match [regex]::Escape($AfterHeading)) ; continue }
        if (-not $inSection) { continue }
        if ($line -notmatch '^\s*\|') { continue }
        if ($line -match '^\s*\|[\s\-:|]+\|\s*$') { $seenHeader = $true; continue }   # separator row
        if (-not $seenHeader) { continue }                                            # header row
        $cells = ($line.Trim().Trim('|') -split '\|') | ForEach-Object { $_.Trim() }
        $rows += ,$cells
    }
    return $rows
}

function Parse-Triangle {
    param([string]$cell)
    $ascii = ConvertTo-AsciiDashes $cell
    $pts = [ordered]@{}
    foreach ($m in [regex]::Matches($ascii, '([ABC])\(\s*(-?\d+)\s*,\s*(-?\d+)\s*\)')) {
        $pts[$m.Groups[1].Value] = @([int]$m.Groups[2].Value, [int]$m.Groups[3].Value)
    }
    return $pts
}

function ConvertFrom-ModuleFacts {
    param([Parameter(Mandatory)][string]$Path)
    $lines = Get-Content -LiteralPath $Path

    $modules = @()
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Grade 8 Geometry arc')) {
        if ($r[0] -notmatch '^M\d') { continue }
        $slug = if ($r[4] -match '`([^`]+)`') { $Matches[1] } else { $null }
        $hash = if ($r[5] -match '`([^`]+)`') { $Matches[1] } else { $r[5] }
        $modules += [ordered]@{
            id                = $r[0]
            displayName       = $r[1]
            standards         = (ConvertTo-AsciiDashes $r[2])
            triangle          = (Parse-Triangle $r[3])
            creativeLabModule = $slug
            iste26Hash        = $hash
        }
    }

    $deploy = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Deploy URLs')) {
        if ($r[1] -match 'https?://\S+') { $deploy[$r[0]] = $Matches[0] }
    }

    $event = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Event')) {
        if ($r[0] -eq 'Name')        { $event.name   = $r[1] }
        if ($r[0] -eq 'Full string') { $event.string = $r[1] }
    }

    return [ordered]@{ modules = $modules; deployUrls = $deploy; event = $event }
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts
```

- [ ] **Step 5: Run tests to verify they pass**

Run: `Invoke-Pester ops/tests/HubContext.Tests.ps1`
Expected: PASS (6 tests).

- [ ] **Step 6: Commit**

```powershell
git add ops/lib/HubContext.psm1 ops/tests/HubContext.Tests.ps1 ops/tests/fixtures/module-facts.md
git commit -m "feat(ops): parse module-facts.md into a canonical object"
```

---

## Task 3: Source hash + JSON render (TDD)

**Files:**
- Modify: `ops/lib/HubContext.psm1`
- Modify: `ops/tests/HubContext.Tests.ps1`

- [ ] **Step 1: Add failing tests**

```powershell
Describe "Get-SourceHash" {
    It "is stable for identical content and changes when content changes" {
        $a = Get-SourceHash -Text "hello"
        $b = Get-SourceHash -Text "hello"
        $c = Get-SourceHash -Text "hellp"
        $a | Should -Be $b
        $a | Should -Not -Be $c
        $a.Length | Should -Be 64   # sha256 hex
    }
}

Describe "Format-ModuleFactsJson" {
    BeforeAll {
        $facts = ConvertFrom-ModuleFacts -Path $script:fixture
        $script:json = Format-ModuleFactsJson -Facts $facts -SourceHash ('x'*64) -GeneratedOn '2026-05-30'
        $script:obj  = $script:json | ConvertFrom-Json
    }
    It "embeds generation metadata including the source hash" {
        $script:obj._generated.sourceHash | Should -Be ('x'*64)
        $script:obj._generated.on | Should -Be '2026-05-30'
    }
    It "serializes triangle coords as integer pairs" {
        $m1 = $script:obj.modules | Where-Object id -eq 'M1'
        @($m1.triangle.A) | Should -Be @(-3,-2)
    }
    It "round-trips deploy URLs" {
        $script:obj.deployUrls.'portfolio' | Should -Be 'https://randalllapointjr.dev'
    }
}
```

- [ ] **Step 2: Run to verify failure**

Run: `Invoke-Pester ops/tests/HubContext.Tests.ps1`
Expected: FAIL — functions not defined.

- [ ] **Step 3: Implement**

```powershell
function Get-SourceHash {
    param([Parameter(Mandatory)][string]$Text)
    $bytes  = [System.Text.Encoding]::UTF8.GetBytes($Text)
    $sha    = [System.Security.Cryptography.SHA256]::Create()
    return (($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Format-ModuleFactsJson {
    param([Parameter(Mandatory)]$Facts, [Parameter(Mandatory)][string]$SourceHash, [string]$GeneratedOn = (Get-Date -Format 'yyyy-MM-dd'))
    $out = [ordered]@{
        _generated = [ordered]@{ from = 'steel/wiki/module-facts.md'; on = $GeneratedOn; sourceHash = $SourceHash }
        event      = $Facts.event
        modules    = $Facts.modules
        deployUrls = $Facts.deployUrls
    }
    return ($out | ConvertTo-Json -Depth 6)
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts, Get-SourceHash, Format-ModuleFactsJson
```

- [ ] **Step 4: Run tests to verify pass**

Run: `Invoke-Pester ops/tests/HubContext.Tests.ps1`
Expected: PASS (all).

- [ ] **Step 5: Commit**

```powershell
git add ops/lib/HubContext.psm1 ops/tests/HubContext.Tests.ps1
git commit -m "feat(ops): source hash + module-facts JSON renderer"
```

---

## Task 4: context.md render (TDD)

**Files:**
- Modify: `ops/lib/HubContext.psm1`
- Modify: `ops/tests/HubContext.Tests.ps1`

`Format-ContextMarkdown` takes the universal vision lines + a per-repo role block and renders the `.hub/context.md` body with the DO-NOT-HAND-EDIT header.

- [ ] **Step 1: Add failing test**

```powershell
Describe "Format-ContextMarkdown" {
    BeforeAll {
        $script:md = Format-ContextMarkdown -Repo 'portfolio' `
            -RoleBlock "Canonical for: the door.`nDependency: consumes creative-lab." `
            -VisionLines @('Manipulation before explanation','Same scalene triangle carries M2 → M3')
    }
    It "starts with the generated DO-NOT-HAND-EDIT marker" {
        $script:md.Split("`n")[0] | Should -Match 'GENERATED by steel/ops/build-context.ps1'
    }
    It "names the repo and includes role + vision content" {
        $script:md | Should -Match '# Shared Context — portfolio'
        $script:md | Should -Match 'consumes creative-lab'
        $script:md | Should -Match 'Manipulation before explanation'
    }
    It "tells consumers to import the JSON, not hardcode" {
        $script:md | Should -Match 'module-facts\.json'
        $script:md | Should -Match 'Never hand-edit'
    }
}
```

- [ ] **Step 2: Run to verify failure.** Expected: FAIL — function not defined.

- [ ] **Step 3: Implement**

```powershell
function Format-ContextMarkdown {
    param([Parameter(Mandatory)][string]$Repo, [Parameter(Mandatory)][string]$RoleBlock, [Parameter(Mandatory)][string[]]$VisionLines)
    $vision = ($VisionLines | ForEach-Object { "- $_" }) -join "`n"
    return @"
<!-- GENERATED by steel/ops/build-context.ps1 — DO NOT HAND-EDIT -->
# Shared Context — $Repo

## This repo's role
$RoleBlock

## Shared vision (all 4 repos)
$vision

## Using these facts
Import values from ``.hub/module-facts.json``. Do not hardcode module names, standards, coords, or URLs.
To change them: edit steel/wiki/module-facts.md → regenerate. Never hand-edit .hub/.
"@
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts, Get-SourceHash, Format-ModuleFactsJson, Format-ContextMarkdown
```

- [ ] **Step 4: Run tests to verify pass.** Expected: PASS.

- [ ] **Step 5: Commit**

```powershell
git add ops/lib/HubContext.psm1 ops/tests/HubContext.Tests.ps1
git commit -m "feat(ops): context.md renderer"
```

---

## Task 5: Git status parser + spoke-path loader (TDD)

**Files:**
- Modify: `ops/lib/HubContext.psm1`
- Modify: `ops/tests/HubContext.Tests.ps1`

Isolate the *pure* part of git-state: turning `git status -sb` porcelain output into a structured verdict. The actual `git` call stays in `repo-state.ps1` (Task 6).

- [ ] **Step 1: Add failing test**

```powershell
Describe "ConvertFrom-GitStatus" {
    It "detects behind/ahead from the branch header" {
        $r = ConvertFrom-GitStatus -Porcelain @('## master...origin/master [behind 3]')
        $r.behind | Should -Be 3; $r.ahead | Should -Be 0; $r.dirty | Should -BeFalse
    }
    It "detects dirty working tree" {
        $r = ConvertFrom-GitStatus -Porcelain @('## main...origin/main', ' M src/App.tsx')
        $r.dirty | Should -BeTrue
    }
    It "is clean and current when only the header line is present" {
        $r = ConvertFrom-GitStatus -Porcelain @('## main...origin/main')
        $r.behind | Should -Be 0; $r.dirty | Should -BeFalse
    }
}
```

- [ ] **Step 2: Run to verify failure.** Expected: FAIL.

- [ ] **Step 3: Implement**

```powershell
function ConvertFrom-GitStatus {
    param([Parameter(Mandatory)][string[]]$Porcelain)
    $header = $Porcelain | Select-Object -First 1
    $rest   = $Porcelain | Select-Object -Skip 1
    $ahead  = if ($header -match 'ahead (\d+)')  { [int]$Matches[1] } else { 0 }
    $behind = if ($header -match 'behind (\d+)') { [int]$Matches[1] } else { 0 }
    $branch = if ($header -match '^##\s+([^\.\s]+)') { $Matches[1] } else { '?' }
    return [ordered]@{ branch = $branch; ahead = $ahead; behind = $behind; dirty = [bool]($rest | Where-Object { $_.Trim() }) }
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts, Get-SourceHash, Format-ModuleFactsJson, Format-ContextMarkdown, ConvertFrom-GitStatus
```

- [ ] **Step 4: Run tests to verify pass.** Expected: PASS.

- [ ] **Step 5: Add a failing test for `Get-SpokePaths`** (single source of spoke paths = `index.md`, per the spec — no hardcoding paths in three scripts)

```powershell
Describe "Get-SpokePaths" {
    It "reads all four spokes and their paths from index.md's Local paths table" {
        $vault = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent   # steel/ops/tests -> steel/
        (Test-Path (Join-Path $vault 'index.md')) | Should -BeTrue       # fail loudly if path math is wrong
        $p = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')
        $p.Keys | Should -Contain 'creative-lab'
        $p.Keys | Should -Contain 'iste-26'
        $p.Count | Should -Be 4
        $p.'portfolio' | Should -Match 'personal/portfolio$'
    }
}
```

- [ ] **Step 6: Run to verify failure.** Expected: FAIL — `Get-SpokePaths` not defined.

- [ ] **Step 7: Implement** (reuses `Get-MarkdownTableRows`; strips the backticks around paths)

```powershell
function Get-SpokePaths {
    param([Parameter(Mandatory)][string]$IndexPath)
    $lines = Get-Content -LiteralPath $IndexPath
    $map = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Local paths')) {
        $spoke = $r[0].Trim('`',' '); $path = $r[1].Trim('`',' ')
        if ($spoke -and $path) { $map[$spoke] = $path }
    }
    return $map
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts, Get-SourceHash, Format-ModuleFactsJson, Format-ContextMarkdown, ConvertFrom-GitStatus, Get-SpokePaths
```

- [ ] **Step 8: Run tests to verify pass.** Expected: PASS.

- [ ] **Step 9: Commit**

```powershell
git add ops/lib/HubContext.psm1 ops/tests/HubContext.Tests.ps1
git commit -m "feat(ops): git status parser + index.md spoke-path loader"
```

---

## Task 6: repo-state.ps1 (git preflight orchestrator)

**Files:**
- Create: `ops/repo-state.ps1`

- [ ] **Step 1: Implement**

```powershell
# ops/repo-state.ps1  — read-only git preflight across all spokes
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
    $porc = git -C $path status -sb 2>$null
    $st = ConvertFrom-GitStatus -Porcelain $porc
    $st['repo'] = $name; $st['fetched'] = $fetchOk
    $results += [pscustomobject]$st
    if ($st.behind -gt 0 -or $st.dirty -or -not $fetchOk) { $problems++ }
}

$results | Format-Table repo, branch, ahead, behind, dirty, fetched -AutoSize | Out-String | Write-Host
if (($results | Where-Object { -not $_.fetched }).Count -gt 0) {
    Write-Host "  NOTE: some repos could not fetch (offline?) — comparisons are local-only." -ForegroundColor DarkYellow
}
# Expose for callers
$global:RepoState = $results
exit $problems
```

- [ ] **Step 2: Manual verification**

Run: `pwsh ops/repo-state.ps1`
Expected: a table with one row per existing spoke; non-zero exit if any repo is behind/dirty/unfetched. (Per the sprint doc, `iste-26` is expected to show `behind > 0` until pulled — confirms the guard works.)

- [ ] **Step 3: Commit**

```powershell
git add ops/repo-state.ps1
git commit -m "feat(ops): read-only git-state preflight across spokes"
```

---

## Task 7: build-context.ps1 (generator orchestrator)

**Files:**
- Create: `ops/build-context.ps1`

- [ ] **Step 1: Implement**

```powershell
# ops/build-context.ps1 — generate .hub/ bundle into each spoke (vault -> repos)
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
if ($facts.modules.Count -ne 3) { Write-Host "Parse error: expected 3 modules, got $($facts.modules.Count). Aborting — no bundles written." -ForegroundColor Red; exit 1 }
$hash  = Get-SourceHash -Text $raw
$json  = Format-ModuleFactsJson -Facts $facts -SourceHash $hash

# 3. Per-repo role + vision (vision is universal; role from projects/<repo>.md ## Role)
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
    Write-Host "  wrote  $name/.hub/  (run 'git -C $path diff --stat .hub' to review)" -ForegroundColor Green
}
Write-Host "`nDone. Review each repo's .hub/ diff, then commit it in that repo." -ForegroundColor Cyan
```

- [ ] **Step 2: Manual verification (idempotence)**

```powershell
pwsh ops/build-context.ps1 -Force      # first run writes .hub/ in each spoke
pwsh ops/build-context.ps1 -Force      # second run
git -C C:/Users/rplap/OneDrive/Desktop/personal/portfolio status --porcelain .hub
```
Expected: after the second run, the portfolio `.hub` diff is empty (deterministic output).

- [ ] **Step 3: Commit (vault side only — `.hub/` is committed inside each spoke later, Task 10)**

```powershell
git add ops/build-context.ps1
git commit -m "feat(ops): generate .hub bundle into each spoke"
```

---

## Task 8: drift-check.ps1 (two-stage rewrite)

**Files:**
- Modify: `ops/drift-check.ps1` (full rewrite)

- [ ] **Step 1: Implement the rewrite**

```powershell
# ops/drift-check.ps1 — two-stage drift validation against canonical module-facts
Import-Module "$PSScriptRoot/lib/HubContext.psm1" -Force
$vault   = Split-Path $PSScriptRoot -Parent
$factsMd = Join-Path $vault 'wiki/module-facts.md'
$spokes  = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')
$base    = Split-Path $spokes.'creative-lab' -Parent   # repo-internal file paths below are drift-check-specific

# 0. Preflight — refuse a PASS verdict if any repo is behind origin
& "$PSScriptRoot/repo-state.ps1" | Out-Null
$stale = $LASTEXITCODE -ne 0

# Canonical truth
$raw    = Get-Content -LiteralPath $factsMd -Raw
$facts  = ConvertFrom-ModuleFacts -Path $factsMd
$canHash= Get-SourceHash -Text $raw

$pass=0; $fail=0; $issues=@()
function Check($label,$file,$pattern){
    if (-not (Test-Path $file)) { Write-Host "  SKIP  $label" -ForegroundColor DarkYellow; return }
    if (Select-String -Path $file -Pattern $pattern -Quiet) { Write-Host "  PASS  $label" -ForegroundColor Green; $script:pass++ }
    else { Write-Host "  FAIL  $label" -ForegroundColor Red; $script:fail++; $script:issues += "  - $label`n      file: $file`n      expected: $pattern" }
}

# Stage 1 — bundle freshness (each repo's .hub hash == canonical hash)
Write-Host "`nStage 1 — bundle freshness" -ForegroundColor Cyan
foreach ($name in $spokes.Keys) {
    $jf = Join-Path $spokes[$name] '.hub/module-facts.json'
    if (-not (Test-Path $jf)) { Write-Host "  SKIP  $name (.hub not installed)" -ForegroundColor DarkYellow; continue }
    $rh = (Get-Content $jf -Raw | ConvertFrom-Json)._generated.sourceHash
    if ($rh -eq $canHash) { Write-Host "  PASS  $name bundle current" -ForegroundColor Green; $pass++ }
    else { Write-Host "  FAIL  $name bundle STALE (regenerate)" -ForegroundColor Red; $fail++; $issues += "  - $name .hub stale: run ops/build-context.ps1 + commit" }
}

# Stage 2 — code conformance (source contains canonical values; CROSS-references only)
Write-Host "`nStage 2 — code conformance" -ForegroundColor Cyan
$clModules="$base/creative-lab/src/config/modules.ts"; $portApp="$base/portfolio/src/App.tsx"
$isteApp="$base/iste-26/src/App.tsx"
$guide=@{ M1="$base/iste-26/src/components/lab-guides/RigidMotions.tsx"; M2="$base/iste-26/src/components/lab-guides/Dilations.tsx"; M3="$base/iste-26/src/components/lab-guides/PythagoreanTheorem.tsx" }
foreach ($m in $facts.modules) {
    $name=[regex]::Escape($m.displayName); $std=[regex]::Escape(($m.standards -split '-')[0])
    Check "$($m.id) name — creative-lab"       $clModules    $name
    Check "$($m.id) name — portfolio"          $portApp      $name
    Check "$($m.id) name — iste-26 guide"      $guide[$m.id] $name
    Check "$($m.id) standards — iste-26 guide" $guide[$m.id] $std
    Check "$($m.id) hash route — iste-26 App"  $isteApp ([regex]::Escape($m.iste26Hash.TrimStart('#')))
}
# Deploy URLs: only check a URL where a repo legitimately links to ANOTHER surface.
# A site never hardcodes its own absolute origin, so we do NOT check a repo's own URL.
$clUrl=[regex]::Escape($facts.deployUrls.'creative-lab')
Check "creative-lab URL — portfolio" $portApp $clUrl
foreach ($id in 'M1','M2','M3') { Check "creative-lab URL — iste-26 $id guide" $guide[$id] $clUrl }
Check "iste-26 #dilations href — portfolio"           $portApp 'iste-26\.vercel\.app.*#dilations'
Check "iste-26 #pythagorean-theorem href — portfolio" $portApp 'iste-26\.vercel\.app.*#pythagorean-theorem'
Check "event name — iste-26 RigidMotions" $guide.M1 ([regex]::Escape($facts.event.name))

# Triangle coords are NOT substring-checked in Stage 2. They live in creative-lab in
# inconsistent, module-specific formats ([[x,y]] arrays vs {x,y} objects, some inside
# __tests__), so substring matching produces false PASS/FAIL. Coords are instead carried
# canonically in .hub/module-facts.json and covered by Stage 1 freshness. Per-module coord
# conformance against each canonical file is deferred to rung 2 (post-ISTE). See the
# "M1 coordinate discrepancy" note at the top of this plan before relying on M1 coords.

# Summary
Write-Host "`n─────────────────────────────" -ForegroundColor DarkGray
Write-Host "  $pass passed | $fail failed" -ForegroundColor ($(if($fail){'Red'}else{'Green'}))
if ($issues) { Write-Host "`nFailures:" -ForegroundColor Red; $issues | ForEach-Object { Write-Host $_ } }
if ($stale)  { Write-Host "`n  VERDICT: UNVERIFIED — a spoke is behind origin or dirty. Pull, then re-run. Not a PASS." -ForegroundColor Yellow; exit 2 }
elseif ($fail){ exit 1 } else { Write-Host "`n  VERDICT: all Tier 1 fields aligned." -ForegroundColor Green }
```

- [ ] **Step 2: Manual verification**

Run: `pwsh ops/drift-check.ps1`
Expected: Stage 1 reports "not installed" until Task 10 runs; Stage 2 PASS/FAIL per field; if `iste-26` is behind origin, the verdict is **UNVERIFIED** (exit 2), proving the staleness gate. Then mutate a name in a spoke source and confirm exactly that check FAILs.

- [ ] **Step 3: Commit**

```powershell
git add ops/drift-check.ps1
git commit -m "feat(ops): two-stage drift-check against canonical JSON with staleness gate"
```

---

## Task 9: Skill updates

**Files:**
- Modify: `.claude/skills/drift-check/SKILL.md`
- Modify: `.claude/skills/session-start/SKILL.md`
- Create: `.claude/skills/build-context/SKILL.md`

- [ ] **Step 1: drift-check SKILL** — replace the "Steps"/"Scope" body to describe: (1) preflight via repo-state, (2) Stage 1 freshness, (3) Stage 2 conformance (names, standards, hash routes, cross-referenced deploy URLs; coords carried in the bundle, not substring-checked), (4) UNVERIFIED verdict when a spoke is behind origin. Keep the canonical-value pointer to `wiki/module-facts.md`. **Remove BOTH hardcoded `27` literals** — "If all 27 checks pass" *and* the next line "Drift check: 27/27 passing". The count is now dynamic; report the actual `$pass`/`$fail` the script prints.

- [ ] **Step 2: session-start SKILL** — in the briefing template, add a `GIT` line above `DRIFT` populated from `ops/repo-state.ps1` (repo · ahead/behind · dirty). **Change the `DRIFT  <X>/27 passing` line to `DRIFT  <pass> pass / <fail> fail`** (drop the `/27` literal — the total is no longer fixed). Keep sprint state live-read; do not commit it anywhere.

- [ ] **Step 3: build-context SKILL** — create thin skill:

```markdown
---
name: build-context
description: Use when the user says "regenerate the bundle", "rebuild .hub", "push facts to repos", or after editing wiki/module-facts.md. Regenerates each spoke's .hub/ from canonical vault facts.
version: 1.0.0
---

# Build Context

Regenerates the `.hub/` bundle in every spoke from `wiki/module-facts.md`.

## Steps
1. Run `pwsh C:\Users\rplap\OneDrive\Desktop\steel\ops\build-context.ps1`
2. If it stops on behind/dirty repos, tell the user which, and ask to pull or re-run with `-Force`.
3. For each spoke, show `git -C <path> diff --stat .hub` and remind the user to commit `.hub/` *inside that repo*.
4. Never hand-edit `.hub/` — it is generated.
```

- [ ] **Step 4: Commit**

```powershell
git add .claude/skills
git commit -m "docs(skills): update drift-check + session-start, add build-context skill"
```

---

## Task 10: One-time rollout into the spokes (manual, operator-driven)

**Files:** (in each spoke repo, not the vault)
- Create: `<spoke>/.hub/module-facts.json`, `<spoke>/.hub/context.md`
- Modify: `<spoke>/CLAUDE.md` (one pointer line)

- [ ] **Step 1: Generate** — `pwsh ops/build-context.ps1` (pull any behind spoke first).
- [ ] **Step 2:** In each spoke, review `git diff .hub`, then commit on a branch per that repo's CLAUDE.md workflow:

```powershell
$p='C:/Users/rplap/OneDrive/Desktop/personal/portfolio'
git -C $p checkout -b chore/hub-bundle
git -C $p add .hub
git -C $p commit -m "chore: add steel .hub canonical bundle"
```

- [ ] **Step 3:** Add one line to each spoke's `CLAUDE.md`: "Canonical shared facts live in `.hub/` (generated by steel; do not hand-edit). Import values from `.hub/module-facts.json`."
- [ ] **Step 4:** Re-run `pwsh ops/drift-check.ps1` — Stage 1 should now PASS for every installed spoke.

---

## Task 11: GitHub repo (the "good stopping point")

**Files:** none (remote setup)

- [ ] **Step 1: Run the full test suite green**

Run: `Invoke-Pester ops/tests/HubContext.Tests.ps1`
Expected: all PASS.

- [ ] **Step 2: Run drift-check clean**

Run: `pwsh ops/drift-check.ps1`
Expected: verdict line = "all Tier 1 fields aligned" (or UNVERIFIED only if a spoke genuinely needs a pull).

- [ ] **Step 3: Create the GitHub repo and push** (private — vault holds operational context)

```powershell
gh repo create steel --private --source . --remote origin --push
```

- [ ] **Step 4: Confirm** `gh repo view --web` shows the vault with `ops/`, `docs/superpowers/`, and skills present.

---

## Verification Summary (maps to spec)

| Spec criterion | Task |
|----------------|------|
| Generator idempotent (zero diff on re-run) | 7 Step 2 |
| Stage 1 flags un-regenerated bundle | 8 Step 2, 10 Step 4 |
| Stage 2 flags hand-edited source | 8 Step 2 |
| Behind-origin spoke → no PASS verdict | 6 Step 2, 8 Step 2 |
| Unicode minus / en-dash normalized | 2 (tests) |
| M2 ≡ M3 triangle treated as intentional | 2 (tests) |
| Event string sourced from module-facts.md, not hardcoded | 1, 3 (tests) |

## Implementation deviations (recorded during execution)

- **`demo` block added** to the parser + JSON (reconciles plan with the spec's artifact shape, which includes CSE). JSON key order: `_generated, event, modules, demo, deployUrls`.
- **URL regex hardened** to `https?://[^\s)]+` — the original `\S+` captured a trailing `)` from markdown-link cells (the `## Standalone demo` row uses link form). Latent Stage-2 bug, fixed in the module.
- **Fail-closed triangle parse** + **anchored heading match** added as cheap guards against silent bad data. HubContext suite: 43/43.
