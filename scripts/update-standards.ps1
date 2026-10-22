Write-Host "Initializing/updating Git submodules to the commits pinned by this repository..."
Write-Host "This does not select or update to the latest standards release."

git submodule update --init --recursive

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to initialize Git submodules. 'standards/' may be empty. Run 'git submodule update --init --recursive' manually, or clone with '--recurse-submodules'."
    exit $LASTEXITCODE
}

Write-Host "standards/ is at the commit pinned by this repository."
