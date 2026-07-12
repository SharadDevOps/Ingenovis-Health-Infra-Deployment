$BASE = "D:\Terraform2\Ingenovis-Health-Infra-Deployment\deployment\projects"

$ErrorActionPreference = "Stop"

$DESTROY_ORDER = @(
    "$BASE\ai-matching-event\dev",
    "$BASE\platform\hub"
)

foreach ($folder in $DESTROY_ORDER) {
    if (Test-Path $folder) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Yellow
        Write-Host "Destroying: $folder" -ForegroundColor Yellow
        Write-Host "========================================" -ForegroundColor Yellow
        Set-Location $folder
        terraform destroy -auto-approve
        if ($LASTEXITCODE -ne 0) {
            Write-Host "FAILED at $folder -- stopping." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "Skipping (not found): $folder" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "All infrastructure destroyed." -ForegroundColor Green