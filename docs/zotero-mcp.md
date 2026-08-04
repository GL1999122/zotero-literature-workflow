# Zotero MCP 集成指南

本文档介绍如何通过 Zotero MCP 在 TRAE 中以编程方式操作 Zotero 文献库。

## 1. Zotero MCP 是什么

Zotero MCP（Model Context Protocol）服务器把 Zotero 的文献管理能力封装为标准 MCP 工具，使 AI 助手可以直接：

- 搜索条目（`zotero_search_items`）
- 读取条目元数据与全文（`zotero_get_item_metadata` / `zotero_get_item_fulltext`）
- 管理 Collections（`zotero_get_collections` / `zotero_create_collection`）
- 管理笔记、标签、附件（`zotero_create_note` / `zotero_batch_update_tags` / `zotero_attach_file`）
- 从 DOI / URL / BibTeX 添加条目（`zotero_add_by_doi` / `zotero_add_by_url` / `zotero_add_by_bibtex`）
- 阅读 PDF（`zotero_read_pdf_pages`）
- 语义检索（`zotero_semantic_search`）
- 导出参考文献（`zotero_export_bibliography`）

## 2. 常用工具速查

| 场景 | 工具 |
| --- | --- |
| 全文搜索文献库 | `zotero_search_items` |
| 按标签查找 | `zotero_search_by_tag` |
| 读取 PDF 内容 | `zotero_read_pdf_pages` |
| 新建分类 | `zotero_create_collection` |
| 获取分类下条目 | `zotero_get_collection_items` |
| 由 DOI 添加 | `zotero_add_by_doi` |
| 由 BibTeX 添加 | `zotero_add_by_bibtex` |
| 生成参考文献列表 | `zotero_export_bibliography` |

## 3. 典型对话示例

### 检索并总结

```
请搜索文献库中含 "narrow gap" 的条目，列出标题与年份，
并读取前 3 篇的 PDF 第一页，总结其研究方法。
```

### 批量入库

```
请将 D:\literature\downloads\ 下的 PDF 添加为条目，
放入 Collection "GTAW/narrow-gap"（不存在则创建），
并为每篇添加标签 "ng-gtaw"。
```

### 生成参考文献

```
请将 Collection "GTAW/narrow-gap" 中的条目导出为 APA 格式参考文献。
```

## 4. 权限与安全

- 本地 API 模式仅本机访问，风险低。
- 官方 API 模式需要 `ZOTERO_API_KEY`，请勿将 Key 提交到公开仓库。
- 对文献库的写操作（创建、修改、删除）建议先在小范围验证。

## 5. 故障排查

| 现象 | 可能原因 | 处理 |
| --- | --- | --- |
| 工具调用超时 | Zotero 未启动 | 先启动 Zotero 再调用 |
| 找不到条目 | API Key 无权限 | 检查 Key 与用户 ID |
| 附件挂载失败 | 路径含中文/空格 | 使用绝对路径并转义 |
| 同步失败 | 网络/WebDAV 配置 | 参考 troubleshooting.md |

详见 [troubleshooting.md](troubleshooting.md)。
