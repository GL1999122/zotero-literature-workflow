# Configuration / 配置说明

本文档说明 Zotero、MCP、浏览器自动化与同步的配置方法。

## 1. Zotero 配置

### 本地 API（Zotero 7+）

Zotero 7 默认在 `127.0.0.1:23119` 暴露本地 HTTP API：

- 启动 Zotero 后，访问 `http://127.0.0.1:23119/api/users/0/items?limit=1` 可验证本地 API 可用。
- 本地 API 无鉴权（仅本机回环），适用于本机脚本调用。

### 同步设置

`Edit → Settings → Sync`：

- 开启「数据同步」（条目、集合、标签）
- 开启「文件同步」：
  - 免费方案：Zotero 官方存储（300 MB）
  - 大附件：WebDAV（如坚果云、Nextcloud）或第三方云存储

## 2. Zotero MCP 配置

MCP 服务器通过 Zotero 本地 API 或官方 API 访问文献库。示例配置（`config/mcp.example.json`）：

```json
{
  "mcpServers": {
    "zotero": {
      "command": "npx",
      "args": ["-y", "zotero-mcp-server"],
      "env": {
        "ZOTERO_API_KEY": "你的 Zotero API Key（可选，官方 API 需要）",
        "ZOTERO_USER_ID": "你的 Zotero 用户 ID（可选）"
      }
    }
  }
}
```

将上述内容粘贴到 TRAE 的 MCP 配置界面（`设置 → MCP → 添加`），保存后重启 TRAE。

> 注意：`ZOTERO_API_KEY` 仅在需要通过官方 Web API 操作时必需；纯本地操作可留空。

## 3. 浏览器自动化配置

用于自动下载 PDF：

- 浏览器：Chrome 或 Edge（Windows 原生）。
- 自动化：TRAE 内置浏览器自动化能力（agent-browser），无需额外安装。
- 下载目录：建议固定为 `D:\literature\downloads\`，方便批量导入。

## 4. 同步脚本示例

`config/sync.example.ps1` 提供本地备份脚本骨架：

```powershell
# 将 Zotero 数据目录备份到外部磁盘
$src = "$env:APPDATA\Zotero\Zotero\Profiles"
$dst = "E:\backup\zotero-$(Get-Date -Format yyyyMMdd)"
Copy-Item -Path $src -Destination $dst -Recurse -Force
Write-Host "备份完成: $dst"
```

## 5. 环境变量汇总

| 变量 | 说明 | 必需 |
| --- | --- | --- |
| `ZOTERO_API_KEY` | Zotero 官方 API Key | 仅官方 API 时 |
| `ZOTERO_USER_ID` | Zotero 用户 ID | 仅官方 API 时 |
| `LIT_DOWNLOAD_DIR` | PDF 下载目录 | 否（默认 `D:\literature\downloads`） |
