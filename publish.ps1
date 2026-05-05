param(
  [string]$RemoteUrl = 'https://github.com/Baahl11/sql-decision-analysis.git'
)

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $scriptDir
try {
  if (-not (Test-Path '.git')) {
    git init | Out-Host
  }

  $status = git status --porcelain
  if ($status) {
    git add . | Out-Host
    git commit -m 'chore: publish update' | Out-Host
  }

  git branch -M main | Out-Host

  $hasOrigin = git remote | Select-String -SimpleMatch 'origin'
  if ($hasOrigin) {
    git remote set-url origin $RemoteUrl | Out-Host
  } else {
    git remote add origin $RemoteUrl | Out-Host
  }

  git push -u origin main | Out-Host
  Write-Host 'Publish completed successfully.' -ForegroundColor Green
} finally {
  Pop-Location
}
