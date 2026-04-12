# Stops all containers, wipes Solr data, and restarts the environment.
# Solr collections will be recreated from scratch by solr-init.

$ErrorActionPreference = "Stop"

Write-Host "Stopping containers..." -ForegroundColor Yellow
docker compose down

Write-Host "Removing Solr data..." -ForegroundColor Yellow
$solrData = ".\data\solr-data"
if (Test-Path $solrData) {
    Remove-Item $solrData -Recurse -Force
    Write-Host "Solr data removed." -ForegroundColor Green
} else {
    Write-Host "Solr data directory not found, skipping." -ForegroundColor Gray
}

Write-Host "Starting environment..." -ForegroundColor Green
.\up.ps1 -SkipBuild
