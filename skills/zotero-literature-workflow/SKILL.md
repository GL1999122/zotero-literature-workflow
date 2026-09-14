---
name: zotero-literature-workflow
description: AI-assisted scientific literature management workflow: retrieval, screening, download, Zotero organization and sync. Use when the user wants to search, download, organize, import, or sync academic literature through Zotero. 科研文献管理全流程：检索、筛选、下载、Zotero 分类整理、精读摘要、研究现状与空白分析与同步。
---

# Zotero Literature Workflow Skill

将「科研文献管理」封装为可复用的工作流，包含检索、筛选、下载、入库、分类、精读摘要、研究现状与空白分析、同步等阶段。

## When to Use

- 用户需要检索/下载学术文献（知网、IEEE、Elsevier、Springer、MDPI、arXiv 等）
- 用户需要将 PDF 导入 Zotero 并整理分类
- 用户需要验证或修复 Zotero 同步
- 用户需要逐篇精读并生成规范短标题 + 中文摘要
- 用户需要归纳研究现状、识别研究空白或寻找选题方向
- 用户需要从文献库生成参考文献列表

## Workflow Steps

1. **需求定义**：确认研究主题、对象域（直接主题命中少时的近邻扩展）、关键词、时间范围、来源库、质量门槛（中文 EI / SCI Q2 等）。
2. **AI 检索**：使用 WebSearch / 数据库查询输出结构化列表（标题/作者/年份/来源/DOI/链接）。
3. **筛选分档**：按相关性、质量门槛、可获取性筛选，建议分 A/B/C 三档（核心/直接/外围）。
4. **下载**：用浏览器自动化下载 PDF 到真实下载目录（先探测），按 SHA-256 去重；参考 docs/lessons-learned.md 的站点反爬绕行技巧。
5. **Zotero 入库**：使用 Zotero MCP（`zotero_add_by_doi` / `zotero_add_by_url` / `zotero_attach_file`）创建条目并挂载附件；写失败仅重试失败条目，连接被拒时降级 BibTeX。
6. **分类整理**：建父集合 + 按研究方向建子集合，条目归类到子集合，按需加标签。
7. **精读与中文摘要**（按需）：用 `zotero_get_item_fulltext` 提取摘要+引言，写法真实、数值规范的短标题与中文摘要，写入 `short_title` 与 `abstract` 字段。
8. **研究现状与空白分析**：对已入库/精读文献按方向聚类，归纳**研究现状**（演进脉络、代表方法、关键结论，须引用具体文献）；交叉识别**研究空白**（未覆盖的对象/工况/方法/维度/时间窗口），输出结构化综述与选题方向。
9. **同步与交付**：核对条目/附件，产出核心交付物，删除中间产物。

## Key Tools

| 阶段 | 工具 |
| --- | --- |
| 检索 | WebSearch / WebFetch |
| 下载 | agent-browser（浏览器自动化） |
| 入库 | Zotero MCP `zotero_add_by_doi` 等 |
| 分类 | Zotero MCP `zotero_create_collection` / `zotero_batch_update_tags` |
| 精读 | Zotero MCP `zotero_get_item_fulltext` / `zotero_update_item` |
| 现状与空白 | 精读结果 + 结构化归纳（无需专用工具） |
| 同步 | Zotero 内置同步 + 备份脚本 |

## Guardrails

- 仅下载合法可获取的文献，遵守版权与下载规范。
- 不在公开仓库中提交任何 API Key / Token。
- 对文献库的批量写操作前先小范围验证。
- 遇到 403/风控时降低频率或更换渠道，不强行绕过；必要时请用户机构授权。
- 中文摘要务必真实规范，保留原文方法与数值，不臆测事实。
- 研究现状须引用具体文献；研究空白须基于已读文献，不得臆造“无人研究”。

## References

- docs/quickstart.md — 快速开始
- docs/workflow.md — 完整工作流
- docs/lessons-learned.md — 实战经验与防错清单
- docs/configuration.md — 配置说明
- docs/zotero-mcp.md — Zotero MCP 集成
- docs/troubleshooting.md — 排错手册
- docs/one-shot-prompt.md — 可复用提示词模板
