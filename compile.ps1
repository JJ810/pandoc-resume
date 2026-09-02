# Build resume HTML and PDF on Windows (always overwrites resume.pdf)
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
    $tmp = Join-Path $PSScriptRoot "resume.tmp.pdf"
    Remove-Item -Force $tmp -ErrorAction SilentlyContinue
    pandoc resume.md --template=template.tex --pdf-engine=xelatex -o $tmp
    if (-not (Test-Path $tmp)) {
        Write-Error "PDF build failed — resume.tmp.pdf was not created."
    }
    try {
        Move-Item -Force $tmp (Join-Path $PSScriptRoot "resume.pdf")
    } catch {
        Write-Error @"
Could not overwrite resume.pdf (file is locked).
Close any PDF viewer that has resume.pdf open, then run again.
"@
    }
} else {
    Write-Warning "xelatex not found - skipped resume.pdf. Install MiKTeX: winget install --id MiKTeX.MiKTeX -e"
}

Write-Host "Done."
Get-Item index.html, resume.pdf | Format-Table Name, Length, LastWriteTime
