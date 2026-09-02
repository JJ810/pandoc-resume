# Build resume HTML and PDF on Windows (no make required)
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

function Add-ToolPath {
    param([string[]]$Candidates)
    foreach ($dir in $Candidates) {
        if (Test-Path $dir) {
            $env:PATH = "$dir;$env:PATH"
            return
        }
    }
}

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Add-ToolPath @(
        "$env:LOCALAPPDATA\Pandoc",
        "$env:ProgramFiles\Pandoc"
    )
}

if (-not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
    Add-ToolPath @(
        "$env:LOCALAPPDATA\Programs\MiKTeX\miktex\bin\x64",
        "$env:ProgramFiles\MiKTeX\miktex\bin\x64"
    )
}

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error @"
pandoc was not found on PATH.

Install it with:
  winget install --id JohnMacFarlane.Pandoc -e

Then close and reopen PowerShell before running this script again.
"@
}

Write-Host "Building index.html..."
pandoc resume.md -s --template=template.html -c style.css -o index.html

if (Get-Command xelatex -ErrorAction SilentlyContinue) {
    Write-Host "Building resume.pdf..."
    pandoc resume.md --template=template.tex --pdf-engine=xelatex -o resume.pdf
} else {
    Write-Warning "xelatex not found — skipped resume.pdf. Install MiKTeX: winget install --id MiKTeX.MiKTeX -e"
}

Write-Host "Done."
