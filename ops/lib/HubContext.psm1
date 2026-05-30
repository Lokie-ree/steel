# ops/lib/HubContext.psm1
# Pure functions (no git, no console) for the steel hub vault pipeline.

function ConvertTo-AsciiDashes {
    param([string]$s)
    # U+2212 minus sign, en-dash U+2013, em-dash U+2014 -> ASCII hyphen
    return ($s -replace "[−–—]", '-')
}

function Get-MarkdownTableRows {
    param([string[]]$Lines, [string]$AfterHeading)
    $rows = @()
    $inSection = $false
    $seenHeader = $false
    foreach ($line in $Lines) {
        if ($line -match "^#+\s") {
            if ($inSection) { break }
            # Fix 4: anchor the heading match so 'Event' does not match '## Event Notes'
            $inSection = ($line -match ('^#+\s+' + [regex]::Escape($AfterHeading) + '\b'))
            $seenHeader = $false
            continue
        }
        if (-not $inSection) { continue }
        if ($line -notmatch '^\s*\|') { continue }
        if ($line -match '^\s*\|[\s\-:|]+\|\s*$') { $seenHeader = $true; continue }
        if (-not $seenHeader) { continue }
        $cells = ($line.Trim().Trim('|') -split '\|') | ForEach-Object { $_.Trim() }
        $rows += , $cells
    }
    # Use Write-Output -NoEnumerate so a single-row result is not unrolled:
    # without this, foreach ($r in (Get-MarkdownTableRows ...)) would iterate
    # the cells of the one row rather than iterating the rows themselves.
    Write-Output -NoEnumerate $rows
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
        $tri = Parse-Triangle $r[3]
        # Fix 3: fail-closed — require exactly 3 triangle points (A, B, C)
        if ($tri.Count -ne 3 -or -not ($tri.Contains('A') -and $tri.Contains('B') -and $tri.Contains('C'))) {
            throw "Triangle parse failed for $($r[0]): $($r[3])"
        }
        $modules += [ordered]@{
            id             = $r[0]
            displayName    = $r[1]
            standards      = (ConvertTo-AsciiDashes $r[2])
            triangle       = $tri
            creativeLabModule = $slug
            iste26Hash     = $hash
        }
    }
    $deploy = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Deploy URLs')) {
        # Fix 1: exclude trailing ')' from URL match (handles markdown-link cells)
        if ($r[1] -match 'https?://[^\s)]+') { $deploy[$r[0]] = $Matches[0] }
    }
    # Fix 2: parse the 'Standalone demo' table
    $demo = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Standalone demo')) {
        # columns: ID | Name | Standards (adjacent) | Repo | URL
        # Fix 1: exclude trailing ')' from URL match (handles markdown-link cells)
        $url = if ($r[4] -match 'https?://[^\s)]+') { $Matches[0] } else { $r[4] }
        $demo = [ordered]@{ id = $r[0]; name = $r[1]; url = $url }
        break  # only one demo row expected
    }
    $event = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Event')) {
        if ($r[0] -eq 'Name')        { $event.name   = $r[1] }
        # Fix 5: event.string intentionally KEEPS its en-dash — it is a human display string
        # used verbatim in drift-check comparisons. Do NOT normalize it to ASCII hyphen.
        if ($r[0] -eq 'Full string') { $event.string = $r[1] }
    }
    return [ordered]@{ modules = $modules; demo = $demo; deployUrls = $deploy; event = $event }
}

function Get-SourceHash {
    param([Parameter(Mandatory)][string]$Text)
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
    $sha   = [System.Security.Cryptography.SHA256]::Create()
    return (($sha.ComputeHash($bytes) | ForEach-Object { $_.ToString('x2') }) -join '')
}

function Format-ModuleFactsJson {
    param(
        [Parameter(Mandatory)]$Facts,
        [Parameter(Mandatory)][string]$SourceHash,
        [string]$GeneratedOn = (Get-Date -Format 'yyyy-MM-dd')
    )
    # Fix 2: output order: _generated, event, modules, demo, deployUrls (matches spec)
    $out = [ordered]@{
        _generated = [ordered]@{
            from       = 'steel/wiki/module-facts.md'
            on         = $GeneratedOn
            sourceHash = $SourceHash
        }
        event      = $Facts.event
        modules    = $Facts.modules
        demo       = $Facts.demo
        deployUrls = $Facts.deployUrls
    }
    return ($out | ConvertTo-Json -Depth 6)
}

function Format-ContextMarkdown {
    param(
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$RoleBlock,
        [Parameter(Mandatory)][string[]]$VisionLines
    )
    $vision = ($VisionLines | ForEach-Object { "- $_" }) -join "`n"
    return @"
<!-- GENERATED by steel/ops/build-context.ps1 — DO NOT HAND-EDIT -->
# Shared Context — $Repo

## This repo's role
$RoleBlock

## Shared vision (all 4 repos)
$vision

## Using these facts
Import values from ```.hub/module-facts.json```. Do not hardcode module names, standards, coords, or URLs.
To change them: edit steel/wiki/module-facts.md → regenerate. Never hand-edit .hub/.
"@
}

function ConvertFrom-GitStatus {
    param([Parameter(Mandatory)][string[]]$Porcelain)
    $header = $Porcelain | Select-Object -First 1
    $rest   = $Porcelain | Select-Object -Skip 1
    $ahead  = if ($header -match 'ahead (\d+)')  { [int]$Matches[1] } else { 0 }
    $behind = if ($header -match 'behind (\d+)') { [int]$Matches[1] } else { 0 }
    $branch = if ($header -match '^##\s+([^\.\s]+)') { $Matches[1] } else { '?' }
    return [ordered]@{
        branch = $branch
        ahead  = $ahead
        behind = $behind
        dirty  = [bool]($rest | Where-Object { $_.Trim() })
    }
}

function Get-SpokePaths {
    param([Parameter(Mandatory)][string]$IndexPath)
    $lines = Get-Content -LiteralPath $IndexPath
    $map   = [ordered]@{}
    foreach ($r in (Get-MarkdownTableRows -Lines $lines -AfterHeading 'Local paths')) {
        $spoke = $r[0].Trim('`', ' ')
        $path  = $r[1].Trim('`', ' ')
        if ($spoke -and $path) { $map[$spoke] = $path }
    }
    return $map
}

Export-ModuleMember -Function ConvertFrom-ModuleFacts, Get-SourceHash, Format-ModuleFactsJson, Format-ContextMarkdown, ConvertFrom-GitStatus, Get-SpokePaths
