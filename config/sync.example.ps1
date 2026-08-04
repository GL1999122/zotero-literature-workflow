# 示例：Zotero 数据目录本地备份脚本
# 用法：powershell -ExecutionPolicy Bypass -File sync.example.ps1 [-Target E:\backup]
param(
    [string]$Target = "E:\backup"
)

$ErrorActionPreference = "Stop"
$profileDir = Join-Path $env:APPDATA "Zotero\Zotero\Profiles"

if (-not (Test-Path $profileDir)) {
    Write-Error "未找到 Zotero 数据目录: $profileDir"
    exit 1
}

if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
}

$stamp = Get-Date -Format "yyyyMMdd-HHmm"
$dest = Join-Path $Target "zotero-$stamp"

Copy-Item -Path $profileDir -Destination $dest -Recurse -Force
Write-Host "备份完成: $dest"
