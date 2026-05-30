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
}

# ---------------------------------------------------------------------------
# Group 2 — Get-SourceHash + Format-ModuleFactsJson
# ---------------------------------------------------------------------------
Describe "Get-SourceHash" {
    It "returns a 64-char hex string" {
        $h = Get-SourceHash -Text "hello"
        $h.Length | Should -Be 64
        $h | Should -Match '^[0-9a-f]{64}$'
    }

    It "same input produces same hash" {
        $h1 = Get-SourceHash -Text "stable text"
        $h2 = Get-SourceHash -Text "stable text"
        $h1 | Should -Be $h2
    }

    It "different input produces different hash" {
        $h1 = Get-SourceHash -Text "aaa"
        $h2 = Get-SourceHash -Text "bbb"
        $h1 | Should -Not -Be $h2
    }
}

Describe "Format-ModuleFactsJson" {
    BeforeAll {
        $script:facts2 = ConvertFrom-ModuleFacts -Path $script:fixture
        $script:hash   = Get-SourceHash -Text (Get-Content $script:fixture -Raw)
        $script:json   = Format-ModuleFactsJson -Facts $script:facts2 -SourceHash $script:hash -GeneratedOn '2026-05-30'
        $script:parsed = $script:json | ConvertFrom-Json
    }

    It "JSON is valid and parses" {
        $script:parsed | Should -Not -BeNullOrEmpty
    }

    It "_generated.sourceHash matches the hash passed in" {
        $script:parsed._generated.sourceHash | Should -Be $script:hash
    }

    It "_generated.on is the GeneratedOn value" {
        $script:parsed._generated.on | Should -Be '2026-05-30'
    }

    It "_generated.from is correct" {
        $script:parsed._generated.from | Should -Be 'steel/wiki/module-facts.md'
    }

    It "deployUrls.portfolio round-trips" {
        $script:parsed.deployUrls.portfolio | Should -Be 'https://randalllapointjr.dev'
    }

    It "event.name round-trips" {
        $script:parsed.event.name | Should -Be 'ISTE LIVE 2026'
    }

    It "modules has 3 entries" {
        $script:parsed.modules.Count | Should -Be 3
    }
}

# ---------------------------------------------------------------------------
# Group 3 — Format-ContextMarkdown
# ---------------------------------------------------------------------------
Describe "Format-ContextMarkdown" {
    BeforeAll {
        $script:md = Format-ContextMarkdown `
            -Repo 'creative-lab' `
            -RoleBlock 'Hosts the interactive math modules.' `
            -VisionLines @('Students manipulate before they explain.', 'Matching IS verification.')
    }

    It "first line matches GENERATED marker" {
        $firstLine = ($script:md -split "`n")[0]
        $firstLine | Should -Match 'GENERATED by steel/ops/build-context\.ps1'
    }

    It "contains the repo heading" {
        $script:md | Should -Match '# Shared Context — creative-lab'
    }

    It "contains the role block text" {
        $script:md | Should -Match 'Hosts the interactive math modules\.'
    }

    It "renders vision lines as bullets" {
        $script:md | Should -Match '- Students manipulate before they explain\.'
        $script:md | Should -Match '- Matching IS verification\.'
    }

    It "mentions module-facts.json" {
        $script:md | Should -Match 'module-facts\.json'
    }

    It "contains Never hand-edit warning" {
        $script:md | Should -Match 'Never hand-edit'
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
    It "reads all four spokes and their paths from index.md's Local paths table" {
        $vault = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent   # steel/ops/tests -> steel/
        (Test-Path (Join-Path $vault 'index.md')) | Should -BeTrue
        $p = Get-SpokePaths -IndexPath (Join-Path $vault 'index.md')
        $p.Count | Should -Be 4
        $p.Keys | Should -Contain 'creative-lab'
        $p.Keys | Should -Contain 'iste-26'
        $p.'portfolio' | Should -Match 'personal/portfolio$'
    }
}
