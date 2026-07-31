# ops/tests/HubContext.Tests.ps1
# Pester 5 tests for HubContext.psm1

BeforeAll {
    Import-Module "$PSScriptRoot/../lib/HubContext.psm1" -Force
    $script:fixture = "$PSScriptRoot/fixtures/module-facts.md"
}

# ---------------------------------------------------------------------------
# Group 1 — ConvertFrom-ModuleFacts
# ---------------------------------------------------------------------------
Describe "ConvertFrom-ModuleFacts" {
    BeforeAll {
        $script:facts = ConvertFrom-ModuleFacts -Path $script:fixture
    }

    It "parses 3 modules" {
        $script:facts.modules.Count | Should -Be 3
    }

    It "M1 displayName is 'Rigid Motions'" {
        $script:facts.modules[0].displayName | Should -Be 'Rigid Motions'
    }

    It "M1 standards en-dash is normalized to ASCII hyphen" {
        $script:facts.modules[0].standards | Should -Be '8.G.A.1-3'
    }

    It "M1 triangle A is (-3,-2) with Unicode minus normalized" {
        ($script:facts.modules[0].triangle.A -join ',') | Should -Be '-3,-2'
    }

    It "M1 triangle B is (1,-1)" {
        ($script:facts.modules[0].triangle.B -join ',') | Should -Be '1,-1'
    }

    It "M1 triangle C is (-2,1)" {
        ($script:facts.modules[0].triangle.C -join ',') | Should -Be '-2,1'
    }

    It "M2 and M3 share identical triangle A(1,1)" {
        ($script:facts.modules[1].triangle.A -join ',') | Should -Be '1,1'
        ($script:facts.modules[2].triangle.A -join ',') | Should -Be '1,1'
    }

    It "M2 and M3 share identical triangle B(4,2)" {
        ($script:facts.modules[1].triangle.B -join ',') | Should -Be '4,2'
        ($script:facts.modules[2].triangle.B -join ',') | Should -Be '4,2'
    }

    It "M2 and M3 share identical triangle C(2,4)" {
        ($script:facts.modules[1].triangle.C -join ',') | Should -Be '2,4'
        ($script:facts.modules[2].triangle.C -join ',') | Should -Be '2,4'
    }

    It "M1 creativeLabModule is 'rigid-motions'" {
        $script:facts.modules[0].creativeLabModule | Should -Be 'rigid-motions'
    }

    It "M1 iste26Hash is '#rigid-motions'" {
        $script:facts.modules[0].iste26Hash | Should -Be '#rigid-motions'
    }

    It "deployUrls creative-lab is correct" {
        $script:facts.deployUrls.'creative-lab' | Should -Be 'https://creative-lab-five.vercel.app'
    }

    It "deployUrls portfolio is correct" {
        $script:facts.deployUrls.'portfolio' | Should -Be 'https://randalllapointjr.dev'
    }

    It "event.name is 'ISTE LIVE 2026'" {
        $script:facts.event.name | Should -Be 'ISTE LIVE 2026'
    }

    It "event.string contains Orlando and en-dash (preserved)" {
        $script:facts.event.string | Should -Be 'Orlando · June 28 – July 1, 2026'
    }

    # Fix 2 — demo block
    It "demo.id is 'CSE'" {
        $script:facts.demo.id | Should -Be 'CSE'
    }

    It "demo.name is 'Cross-Section Explorer'" {
        $script:facts.demo.name | Should -Be 'Cross-Section Explorer'
    }

    It "demo.url is clean (no trailing paren) — also covers Fix 1 URL regex" {
        $script:facts.demo.url | Should -Be 'https://creative-lab-demos.vercel.app'
    }
}

# ---------------------------------------------------------------------------
# Group 4 — ConvertFrom-GitStatus
# ---------------------------------------------------------------------------
Describe "ConvertFrom-GitStatus" {
    It "parses behind count; ahead defaults to 0; dirty false with header only" {
        $r = ConvertFrom-GitStatus -Porcelain @('## master...origin/master [behind 3]')
        $r.behind | Should -Be 3
        $r.ahead  | Should -Be 0
        $r.dirty  | Should -BeFalse
    }

    It "dirty is true when there are file-change lines" {
        $r = ConvertFrom-GitStatus -Porcelain @('## master...origin/master [behind 3]', ' M src/App.tsx')
        $r.dirty | Should -BeTrue
    }

    It "ahead and behind are both 0 when no tracking info" {
        $r = ConvertFrom-GitStatus -Porcelain @('## main...origin/main')
        $r.behind | Should -Be 0
        $r.ahead  | Should -Be 0
        $r.dirty  | Should -BeFalse
    }

    It "parses branch name" {
        $r = ConvertFrom-GitStatus -Porcelain @('## master...origin/master [behind 3]')
        $r.branch | Should -Be 'master'
    }

    It "parses ahead count" {
        $r = ConvertFrom-GitStatus -Porcelain @('## feat/foo...origin/feat/foo [ahead 2]')
        $r.ahead  | Should -Be 2
        $r.behind | Should -Be 0
    }
}

# ---------------------------------------------------------------------------
# Group 5 — Get-SpokePaths
# ---------------------------------------------------------------------------
Describe "Get-SpokePaths" {
    # The spoke count is derived from index.md, never asserted as a literal:
    # this test hardcoded 4 and went red the moment a fifth spoke registered.
    # Same rule as CLAUDE.md's "git state is derived, never transcribed."
    It "reads every row of index.md's Local paths table" {
        $vault = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent   # steel/ops/tests -> steel/
        $index = Join-Path $vault 'index.md'
        (Test-Path $index) | Should -BeTrue

        $p = Get-SpokePaths -IndexPath $index
        $expected = (Get-Content $index |
            Select-String -Pattern '^\|\s*`?[a-z0-9-]+`?\s*\|\s*`C:/.*`\s*\|' ).Count

        $expected | Should -BeGreaterThan 0
        $p.Count | Should -Be $expected
        $p.Keys | Should -Contain 'creative-lab'
        $p.Keys | Should -Contain 'course-lab'
        $p.'portfolio' | Should -Match 'personal/portfolio$'
    }
}

# ---------------------------------------------------------------------------
# Group 6 — Fix 3: fail-closed triangle parse
# ---------------------------------------------------------------------------
Describe "ConvertFrom-ModuleFacts triangle validation" {
    BeforeAll {
        $script:tmpDir = "$PSScriptRoot/.tmp"
        if (-not (Test-Path $script:tmpDir)) { New-Item -ItemType Directory -Path $script:tmpDir | Out-Null }
        $script:badTrianglePath = "$script:tmpDir/bad-triangle.md"
        Set-Content -LiteralPath $script:badTrianglePath -Value @'
## Event

| Field | Value |
|-------|-------|
| Name | Test Event |
| Full string | City – Date |

## Grade 8 Geometry arc (M1 → M2 → M3)

| ID | Display name | Standards | Triangle | creative-lab | iste-26 hash |
|----|--------------|-----------|----------|--------------|--------------|
| M1 | Bad Module | 8.G.A.1 | NOTVALID | module `bad` | `#bad` |
'@
    }

    AfterAll {
        if (Test-Path $script:badTrianglePath) { Remove-Item -LiteralPath $script:badTrianglePath }
    }

    It "throws when a module triangle does not parse exactly 3 points" {
        { ConvertFrom-ModuleFacts -Path $script:badTrianglePath } | Should -Throw
    }
}
