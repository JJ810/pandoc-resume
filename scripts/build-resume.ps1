# build-resume — build resume.pdf from resume.md in the current folder
# Usage:  build-resume
#         build-resume -Markdown resume.md -OutPdf resume.pdf

[CmdletBinding()]
param(
    [Alias("Input")]
    [string]$Markdown = "resume.md",
    [string]$OutPdf = "Jesse_Pinzon_Resume.pdf"
)

$ErrorActionPreference = "Stop"
$WorkDir = (Get-Location).Path

function Add-ToolPath {
    param([string[]]$Candidates)
    foreach ($dir in $Candidates) {
        if ($dir -and (Test-Path $dir)) {
            $env:PATH = "$dir;$env:PATH"
            return
        }
    }
}

function Resolve-TemplateDir {
    $candidates = @(
        $WorkDir,
        (Join-Path $PSScriptRoot "..\templates"),
        (Join-Path $env:LOCALAPPDATA "pandoc-resume\templates"),
        (Join-Path $env:USERPROFILE "Documents\pandoc-resume")
    )
    foreach ($dir in $candidates) {
        $tex = Join-Path $dir "template.tex"
        if (Test-Path $tex) {
            return (Resolve-Path $dir).Path
        }
    }
    return $null
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

$md = Join-Path $WorkDir $Markdown
if (-not (Test-Path $md)) {
    Write-Error "No '$Markdown' in current folder:`n  $WorkDir`nCreate or edit resume.md, then run build-resume again."
}

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "pandoc not found. Install with: winget install --id JohnMacFarlane.Pandoc -e"
}

if (-not (Get-Command xelatex -ErrorAction SilentlyContinue)) {
    Write-Error "xelatex not found. Install MiKTeX with: winget install --id MiKTeX.MiKTeX -e"
}

$TemplateDir = Resolve-TemplateDir
if (-not $TemplateDir) {
    Write-Error @"
Could not find template.tex.

Put it in this folder, or install shared templates to:
  $env:LOCALAPPDATA\pandoc-resume\templates
"@
}

$templateTex = Join-Path $TemplateDir "template.tex"
$pdfOut = Join-Path $WorkDir $OutPdf
$tmp = Join-Path $WorkDir "resume.tmp.pdf"

Write-Host "Working dir : $WorkDir"
Write-Host "Input       : $md"
Write-Host "Templates   : $TemplateDir"
Write-Host "Building $OutPdf ..."

Remove-Item -Force $tmp -ErrorAction SilentlyContinue
$prevEap = $ErrorActionPreference
$ErrorActionPreference = "Continue"
& pandoc $md --template=$templateTex --pdf-engine=xelatex -o $tmp 2>&1 | Out-Host
$pdfCode = $LASTEXITCODE
$ErrorActionPreference = $prevEap

if ($pdfCode -ne 0 -or -not (Test-Path $tmp)) {
    Write-Error "PDF build failed."
}

$replaced = $false
for ($i = 0; $i -lt 6; $i++) {
    try {
        if (Test-Path $pdfOut) {
            Rename-Item -Force $pdfOut "$OutPdf.bak" -ErrorAction Stop
            Remove-Item -Force (Join-Path $WorkDir "$OutPdf.bak") -ErrorAction SilentlyContinue
        }
        Move-Item -Force $tmp $pdfOut
        $replaced = $true
        break
    } catch {
        Start-Sleep -Milliseconds 500
    }
}

if (-not $replaced) {
    Write-Error "Could not overwrite $OutPdf (file is locked). Close the PDF viewer and run again."
}

Write-Host "Done."
Get-Item $pdfOut | Format-Table Name, Length, LastWriteTime
