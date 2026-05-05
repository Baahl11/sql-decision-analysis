$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$localDuckDb = Join-Path $scriptDir 'tools\duckdb\duckdb.exe'
$workspaceDuckDb = (Resolve-Path (Join-Path $scriptDir '..\tools\duckdb\duckdb.exe') -ErrorAction SilentlyContinue)

$duckdbCmd = Get-Command duckdb -ErrorAction SilentlyContinue
if ($duckdbCmd) {
  $duckdbExe = $duckdbCmd.Source
} elseif (Test-Path $localDuckDb) {
  $duckdbExe = $localDuckDb
} elseif ($workspaceDuckDb) {
  $duckdbExe = $workspaceDuckDb.Path
} else {
  Write-Host 'DuckDB CLI is not available.' -ForegroundColor Yellow
  Write-Host 'Install local DuckDB with:' -ForegroundColor Yellow
  Write-Host '  pwsh -ExecutionPolicy Bypass -File tools/install-duckdb-local.ps1' -ForegroundColor Yellow
  exit 1
}

Push-Location $scriptDir
try {
  $dbPath = 'sql_decision_analysis.duckdb'
  $outPath = 'analysis/query-output.txt'
  $duckdbArgs = @('-ascii', '-table', '-header', $dbPath)

  Get-Content 'sql/01_setup.sql' -Raw | & $duckdbExe @duckdbArgs | Out-Host
  (Get-Content 'sql/02_queries.sql' -Raw | & $duckdbExe @duckdbArgs) | Tee-Object -FilePath $outPath | Out-Host

  Write-Host "Saved query output to $outPath" -ForegroundColor Green
} finally {
  Pop-Location
}
