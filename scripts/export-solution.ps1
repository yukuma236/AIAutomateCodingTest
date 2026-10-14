[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SolutionName,

    [Parameter(Mandatory = $true)]
    [string]$EnvironmentUrl,

    [string]$OutputFolder = "$PSScriptRoot\..\solutions\src"
)

# 前提: 事前に `pac auth create --environment $EnvironmentUrl` で認証済みであること。
# 本スクリプトは常にUnmanaged(開発用)としてexportする。Managed化はpack-solution.ps1側で行う。

$ErrorActionPreference = "Stop"

$zipPath = "$PSScriptRoot\..\solutions\build\$SolutionName.zip"
$unpackFolder = Join-Path $OutputFolder $SolutionName

Write-Host "Exporting solution '$SolutionName' from $EnvironmentUrl ..."
pac solution export --name $SolutionName --path $zipPath --environment $EnvironmentUrl --managed false

if ($LASTEXITCODE -ne 0) {
    Write-Error "pac solution export failed."
    exit $LASTEXITCODE
}

Write-Host "Unpacking to $unpackFolder ..."
pac solution unpack --zipfile $zipPath --folder $unpackFolder --packagetype Unmanaged --allowDelete true

if ($LASTEXITCODE -ne 0) {
    Write-Error "pac solution unpack failed."
    exit $LASTEXITCODE
}

Write-Host "Done. Review the diff under '$unpackFolder' before committing."
