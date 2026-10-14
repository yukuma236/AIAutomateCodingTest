[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SolutionName,

    [ValidateSet("Managed", "Unmanaged")]
    [string]$PackageType = "Managed",

    [string]$SourceFolder = "$PSScriptRoot\..\solutions\src",

    [string]$OutputFolder = "$PSScriptRoot\..\solutions\build"
)

$ErrorActionPreference = "Stop"

$unpackFolder = Join-Path $SourceFolder $SolutionName
$suffix = if ($PackageType -eq "Managed") { "_managed" } else { "" }
$zipPath = Join-Path $OutputFolder "$SolutionName$suffix.zip"

if (-not (Test-Path $unpackFolder)) {
    Write-Error "Solution source folder not found: $unpackFolder"
    exit 1
}

Write-Host "Packing '$SolutionName' as $PackageType ..."
pac solution pack --zipfile $zipPath --folder $unpackFolder --packagetype $PackageType

if ($LASTEXITCODE -ne 0) {
    Write-Error "pac solution pack failed."
    exit $LASTEXITCODE
}

Write-Host "Packed solution written to $zipPath"
