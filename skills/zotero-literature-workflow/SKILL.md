---
name: zotero-literature-workflow
description: AI-assisted scientific literature management workflow: retrieval, screening, download, Zotero organization and sync. Use when the user wants to search, download, organize, import, or sync academic literature through Zotero. 科研文献管理全流程：检索、筛选、下载、Zotero 分类整理与同步。
---

# Zotero Literature Workflow Skill

将「科研文献管理」封装为可复用的工作流，包含检索、筛选、下载、入库、分类、同步六个阶段。

## When to Use

- 用户需要检索/下载学术文献（arXiv、MDPI、出版社等）
- 用户需要将 PDF 导入 Zotero 并整理分类
- 用户需要验证或修复 Zotero 同步
- 用户需要从文献库生成参考文献列表

## Workflow Steps

1. **需求定义**：确认研究主题、关键词、时间范围、来源渠道。
2. **AI 检索**：使用 WebSearch 检索候选文献，输出结构化列表（标题/作者/年份/DOI/链接）。
3. **筛选**：按相关性、期刊质量、可获取性筛选，输出下载清单。
4. **下载**：使用浏览器自动化下载 PDF 到 `LIT_DOWNLOAD_DIR`，按 SHA-256 去重。
5. **Zotero 入库**：使用 Zotero MCP（`zotero_add_by_doi` / `zotero_add_by_url` / `zotero_attach_file`）创建条目并挂载附件。
6. **分类整理**：创建/复用 Collections 与 Tags，组织文献层级。
7. **同步与验证**：触发 Zotero 同步，核对云端条目数；必要时执行本地备份。

## Key Tools

| 阶段 | 工具 |
| --- | --- |
| 检索 | WebSearch / WebFetch |
| 下载 | agent-browser（浏览器自动化） |
| 入库 | Zotero MCP `zotero_add_by_doi` 等 |
| 分类 | Zotero MCP `zotero_create_collection` / `zotero_batch_update_tags` |
| 同步 | Zotero 内置同步 + 备份脚本 |

## Guardrails

- 仅下载合法可获取的文献，遵守版权与下载规范。
- 不在公开仓库中提交任何 API Key / Token。
- 对文献库的批量写操作前先小范围验证。
- 遇到 403/风控时降低频率或更换渠道，不强行绕过。

## References

- docs/quickstart.md — 快速开始
- docs/workflow.md — 完整工作流
- docs/configuration.md — 配置说明
- docs/zotero-mcp.md — Zotero MCP 集成
- docs/troubleshooting.md — 排错手册
