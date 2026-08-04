# Zotero Literature Workflow

AI-assisted scientific literature management workflow: retrieval, screening, download, Zotero organization and sync. Powered by TRAE AI IDE, browser automation, and the Zotero MCP server.

科研文献管理全流程：AI 检索 — 筛选 — 下载 — Zotero 分类整理 — 同步备份。

## Features / 特性

- **AI 检索与筛选**：借助 TRAE 的 AI 能力快速定位相关文献，按主题、方法、年份筛选。
- **自动下载 PDF**：通过浏览器自动化从 arXiv、MDPI、出版社等渠道自动抓取全文 PDF，支持重复文件去重。
- **Zotero 智能整理**：通过 Zotero MCP 自动创建文献条目、分类（Collections）、挂载附件，按研究主题组织个人文献库。
- **批量导入**：支持从本地 PDF 目录批量导入并自动匹配元数据。
- **跨端同步**：配置 Zotero 云同步，本地数据库、附件与云端保持一致，多设备无缝衔接。
- **可复现的工作流**：所有步骤以脚本和 MCP 工具封装，流程可复现、可审计。

## Repository Structure / 目录结构

```
zotero-literature-workflow/
├── README.md                        # 项目总览（本文件）
├── LICENSE                          # 开源许可证
├── docs/
│   ├── quickstart.md                # 快速开始指南
│   ├── workflow.md                  # 完整工作流说明
│   ├── configuration.md             # 配置说明（MCP / 同步 / 浏览器自动化）
│   ├── zotero-mcp.md                # Zotero MCP 集成指南
│   └── troubleshooting.md           # 常见问题与排错手册
├── skills/
│   └── zotero-literature-workflow/  # 可复用的 TRAE Skill 定义
│       └── SKILL.md
└── config/
    ├── mcp.example.json             # MCP 服务器配置示例
    └── sync.example.ps1             # 同步脚本示例
```

## Quick Start / 快速开始

1. 安装 [Zotero](https://www.zotero.org/) 并登录账号（启用同步）。
2. 配置 Zotero 本地 API 或 Zotero MCP（参见 [docs/zotero-mcp.md](docs/zotero-mcp.md)）。
3. 在 TRAE 中加载 Zotero MCP 服务器（参见 [docs/configuration.md](docs/configuration.md)）。
4. 按 [docs/quickstart.md](docs/quickstart.md) 完成首次工作流验证。

## Workflow Overview / 工作流概览

```
1. 需求定义      —— 明确研究主题、检索范围
2. AI 检索       —— 在 arXiv / 出版社 / 数据库检索候选文献
3. 筛选排序      —— 按相关度、发表年份、期刊质量筛选
4. 自动下载      —— 浏览器自动化下载全文 PDF，去重归档
5. Zotero 入库   —— 创建条目 + Collections 分类 + 附件挂载
6. 同步备份      —— Zotero 云同步，多端一致
```

详细步骤见 [docs/workflow.md](docs/workflow.md)。

## Prerequisites / 环境要求

| 组件 | 用途 | 获取方式 |
| --- | --- | --- |
| Zotero (>= 7) | 文献库管理 | https://www.zotero.org/download |
| TRAE AI IDE | AI 工作流编排 | https://www.trae.ai |
| Zotero MCP | 文献库程序化访问 | 见 [docs/zotero-mcp.md](docs/zotero-mcp.md) |
| Python (>= 3.10) | 自动化脚本 | https://www.python.org/downloads |
| Chrome / Edge | 浏览器自动化下载 | 系统自带 |

## Documentation / 文档

- [快速开始 quickstart](docs/quickstart.md)
- [工作流 workflow](docs/workflow.md)
- [配置 configuration](docs/configuration.md)
- [Zotero MCP 集成](docs/zotero-mcp.md)
- [排错手册 troubleshooting](docs/troubleshooting.md)

## License / 许可证

[MIT](LICENSE)

## Disclaimer / 免责声明

本项目仅用于合法的学术文献管理与个人学习用途。请遵守各出版社、数据库的版权条款与下载规范，尊重知识产权。
