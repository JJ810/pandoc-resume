# unzip-build-resume — unzip each .zip in the current folder, then run build-resume
# Usage:  unzip-build-resume
#         unzip-build-resume -Path C:\path\to\folder-of-zips
#         unzip-build-resume -Path C:\path\to\one-resume.zip

[CmdletBinding()]
param(
    [string]$Path = "."
)

$ErrorActionPreference = "Stop"

function Get-BuildResumeScript {
    $beside = Join-Path $PSScriptRoot "build-resume.ps1"
    if (Test-Path $beside) {
        return $beside
    }
    $cmd = Get-Command build-resume -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source) {
        $sibling = Join-Path (Split-Path $cmd.Source -Parent) "build-resume.ps1"
        if (Test-Path $sibling) {
            return $sibling
        }
    }
    Write-Error "build-resume.ps1 not found. Re-run scripts\install-build-resume.ps1."
}

function Get-ZipTargets {
    param([string]$InputPath)

    $resolved = Resolve-Path -LiteralPath $InputPath
    $item = Get-Item -LiteralPath $resolved

    if (-not $item.PSIsContainer) {
        if ($item.Extension -ne ".zip") {
            Write-Error "Not a .zip file: $($item.FullName)"
        }
        return @($item)
    }

    $zips = @(Get-ChildItem -LiteralPath $item.FullName -File -Filter "*.zip" | Sort-Object Name)
    if ($zips.Count -eq 0) {
        Write-Error "No .zip files in:`n  $($item.FullName)"
    }
    return $zips
}

function Expand-ResumeZip {
    param(
        [System.IO.FileInfo]$Zip,
        [string]$DestDir
    )

    $temp = Join-Path ([IO.Path]::GetTempPath()) ("pandoc-resume-" + [guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Force -Path $temp | Out-Null
    New-Item -ItemType Directory -Force -Path $DestDir | Out-Null

    try {
        Expand-Archive -LiteralPath $Zip.FullName -DestinationPath $temp -Force

        $items = @(
            Get-ChildItem -LiteralPath $temp |
                Where-Object { $_.Name -notin @("__MACOSX", ".DS_Store") }
        )

        $source = $temp
        if ($items.Count -eq 1 -and $items[0].PSIsContainer) {
            $source = $items[0].FullName
        }

        Get-ChildItem -LiteralPath $source -Force |
            Where-Object { $_.Name -notin @("__MACOSX", ".DS_Store") } |
            ForEach-Object {
                Copy-Item -LiteralPath $_.FullName -Destination $DestDir -Recurse -Force
            }
    } finally {
        Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Find-ResumeFolder {
    param([string]$Root)

    $direct = Join-Path $Root "resume.md"
    if (Test-Path -LiteralPath $direct) {
        return $Root
    }

    $found = Get-ChildItem -LiteralPath $Root -Filter "resume.md" -Recurse -File -ErrorAction SilentlyContinue |
        Select-Object -First 1
    if ($found) {
        return $found.DirectoryName
    }
    return $null
}

$buildScript = Get-BuildResumeScript
$zips = Get-ZipTargets -InputPath $Path
$results = @()

Write-Host "Found $($zips.Count) zip file(s)."
Write-Host ""

foreach ($zip in $zips) {
    $folderName = [IO.Path]::GetFileNameWithoutExtension($zip.Name)
    $destDir = Join-Path $zip.DirectoryName $folderName
    $status = "OK"
    $detail = $destDir

    Write-Host "===== $folderName ====="

    try {
        Expand-ResumeZip -Zip $zip -DestDir $destDir
        $resumeDir = Find-ResumeFolder -Root $destDir
        if (-not $resumeDir) {
            throw "No resume.md inside $($zip.Name)"
        }

        Push-Location -LiteralPath $resumeDir
        try {
            & $buildScript
            if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
                throw "build-resume failed with exit code $LASTEXITCODE"
            }
        } finally {
            Pop-Location
        }

        Remove-Item -LiteralPath $zip.FullName -Force
        Write-Host "Removed $($zip.Name)"
    } catch {
        $status = "FAIL"
        $detail = $_.Exception.Message
        Write-Host "FAILED: $detail" -ForegroundColor Red
    }

    $results += [pscustomobject]@{
        Zip    = $zip.Name
        Status = $status
        Detail = $detail
    }
    Write-Host ""
}

Write-Host "===== Summary ====="
$results | Format-Table Zip, Status, Detail -AutoSize

$failed = @($results | Where-Object { $_.Status -eq "FAIL" })
if ($failed.Count -gt 0) {
    Write-Error "$($failed.Count) of $($results.Count) zip(s) failed."
}

Write-Host "Done. Processed $($results.Count) zip(s)."
