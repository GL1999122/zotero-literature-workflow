# Quick Start / 快速开始

本指南帮助你在 10 分钟内跑通「文献入库 → 分类 → 同步」的最小工作流。

## 1. 准备 Zotero

1. 下载并安装 [Zotero](https://www.zotero.org/download/)（推荐 7.x）。
2. 打开 Zotero，进入 `Edit → Settings → Sync`，登录你的 Zotero 账号并启用同步。
3. 确认「数据同步」与「文件同步」均已开启（文件同步建议选择「所有附件」或「使用 WebDAV/第三方存储」）。

## 2. 准备 TRAE 与 Zotero MCP

1. 安装 [TRAE](https://www.trae.ai/)。
2. 在 TRAE 的 MCP 配置中添加 Zotero MCP 服务器，配置方法见 [configuration.md](configuration.md)。
3. 重启 TRAE，确认 Zotero MCP 工具已加载（如 `zotero_search_items`、`zotero_create_collection` 等）。

## 3. 首次验证（最小流程）

在 TRAE 对话中执行以下指令验证链路：

```
请用 Zotero MCP 创建一个名为 "My Research" 的顶层 Collection，
然后搜索文献库中已存在的条目并告诉我数量。
```

预期输出：创建 Collection 成功，并返回条目数量。

## 4. 下载一篇 PDF 并入库

1. 打开浏览器（Chrome/Edge），导航到某篇文献的 PDF 页面（如 arXiv 的 `arxiv.org/pdf/xxxx`）。
2. 让 AI 通过浏览器自动化下载 PDF 到本地目录，例如 `D:\literature\downloads\`。
3. 在 TRAE 中执行：

```
请将 D:\literature\downloads\ 下的 PDF 导入 Zotero 的 "My Research" Collection，
并自动抓取元数据。
```

## 5. 触发同步

Zotero 会在检测到新条目后自动同步；也可手动点击工具栏同步按钮，或在 TRAE 中：

```
请检查 Zotero 同步状态，确认条目与附件已同步到云端。
```

## 完成

至此，最小工作流已跑通：`下载 → 入库 → 分类 → 同步`。接下来可阅读 [workflow.md](workflow.md) 了解完整流程，或参考 [troubleshooting.md](troubleshooting.md) 排查问题。
