# Install build-resume and unzip-build-resume as system commands for the current user.
# Run once from the pandoc-resume project:
#   powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1

$ErrorActionPreference = "Stop"
$ProjectRoot = Split-Path $PSScriptRoot -Parent

$InstallRoot = Join-Path $env:LOCALAPPDATA "pandoc-resume"
$BinDir = Join-Path $InstallRoot "bin"
$TemplateDir = Join-Path $InstallRoot "templates"

New-Item -ItemType Directory -Force -Path $BinDir | Out-Null
New-Item -ItemType Directory -Force -Path $TemplateDir | Out-Null

Copy-Item -Force (Join-Path $PSScriptRoot "build-resume.ps1") (Join-Path $BinDir "build-resume.ps1")
Copy-Item -Force (Join-Path $PSScriptRoot "build-resume.cmd") (Join-Path $BinDir "build-resume.cmd")
Copy-Item -Force (Join-Path $PSScriptRoot "unzip-build-resume.ps1") (Join-Path $BinDir "unzip-build-resume.ps1")
Copy-Item -Force (Join-Path $PSScriptRoot "unzip-build-resume.cmd") (Join-Path $BinDir "unzip-build-resume.cmd")

# Remove old command name if present
Remove-Item -Force (Join-Path $BinDir "rebuild-resume.ps1") -ErrorAction SilentlyContinue
Remove-Item -Force (Join-Path $BinDir "rebuild-resume.cmd") -ErrorAction SilentlyContinue

$texSrc = Join-Path $ProjectRoot "template.tex"
if (-not (Test-Path $texSrc)) {
    Write-Error "Missing project file: $texSrc"
}
Copy-Item -Force $texSrc (Join-Path $TemplateDir "template.tex")

# Keep HTML/CSS templates available for local project builds, optional for build-resume
foreach ($f in @("template.html", "style.css")) {
    $src = Join-Path $ProjectRoot $f
    if (Test-Path $src) {
        Copy-Item -Force $src (Join-Path $TemplateDir $f)
    }
}

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$pathParts = @()
if ($userPath) {
    $pathParts = $userPath -split ';' | Where-Object { $_ -and $_.Trim() -ne '' }
}
if ($pathParts -notcontains $BinDir) {
    $newPath = (@($pathParts) + $BinDir) -join ';'
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Added to user PATH: $BinDir"
} else {
    Write-Host "Already on user PATH: $BinDir"
}

if ($env:PATH -notlike "*$BinDir*") {
    $env:PATH = "$BinDir;$env:PATH"
}

Write-Host ""
Write-Host "Installed resume commands."
Write-Host "  Commands  : build-resume, unzip-build-resume"
Write-Host "  Templates : $TemplateDir"
Write-Host ""
Write-Host "Single folder (has resume.md):"
Write-Host "  cd C:\path\to\folder"
Write-Host "  build-resume"
Write-Host ""
Write-Host "Folder of zip files:"
Write-Host "  cd C:\path\to\folder-of-zips"
Write-Host "  unzip-build-resume"
Write-Host ""
Write-Host "Open a NEW terminal if a command is not recognized yet."
Write-Host "See system-command.md for full setup instructions."
