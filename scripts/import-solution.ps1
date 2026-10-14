[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ZipPath,

    [Parameter(Mandatory = $true)]
    [string]$EnvironmentUrl,

    [switch]$PublishWorkflows = $true
)

# 前提: 事前に `pac auth create --environment $EnvironmentUrl` で認証済みであること。
# Production環境へのimportは、承認プロセス(CI/CDのEnvironment保護ルール等)を経てから実行すること。

$ErrorActionPreference = "Stop"

if (-not (Test-Path $ZipPath)) {
    Write-Error "Solution package not found: $ZipPath"
    exit 1
}

Write-Host "Importing $ZipPath into $EnvironmentUrl ..."
$publishArg = if ($PublishWorkflows) { "--publish-changes true" } else { "--publish-changes false" }

pac solution import --path $ZipPath --environment $EnvironmentUrl --async true --max-async-wait-time 60 $publishArg

if ($LASTEXITCODE -ne 0) {
    Write-Error "pac solution import failed."
    exit $LASTEXITCODE
}

Write-Host "Import completed."
