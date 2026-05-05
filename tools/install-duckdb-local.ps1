$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$duckDir = Join-Path $repoRoot 'tools\duckdb'

New-Item -ItemType Directory -Force -Path $duckDir | Out-Null

$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/duckdb/duckdb/releases/latest'
$asset = $release.assets | Where-Object { $_.name -match '^duckdb_cli-windows-amd64.zip$' } | Select-Object -First 1

if (-not $asset) {
  throw 'Could not find duckdb_cli-windows-amd64.zip in latest DuckDB release assets.'
}

$zipPath = Join-Path $duckDir $asset.name
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $duckDir -Force
Remove-Item $zipPath -Force

$duckdbExe = Join-Path $duckDir 'duckdb.exe'
if (-not (Test-Path $duckdbExe)) {
  throw 'DuckDB executable was not found after extraction.'
}

& $duckdbExe --version
Write-Host "Installed local DuckDB at $duckdbExe" -ForegroundColor Green
