Write-Host "Initializing Git submodules (standards)..."

git submodule update --init --recursive

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to initialize Git submodules. 'standards/' may be empty. Run 'git submodule update --init --recursive' manually, or clone with '--recurse-submodules'."
    exit $LASTEXITCODE
}

Write-Host "standards/ submodule is up to date."
