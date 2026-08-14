# Workflow / 完整工作流

本文档描述本项目的端到端文献管理工作流，每个阶段都可由 AI 驱动并复现。

## 阶段总览

```
1. 需求定义 → 2. AI 检索 → 3. 筛选 → 4. 下载 → 5. Zotero 入库 → 6. 分类整理 → 7. 同步备份
```

## 1. 需求定义

明确研究问题，形成检索关键词集。示例：

- 主题：窄间隙钨极氩弧焊（Narrow-Gap GTAW）中的熔池行为
- 关键词：`GTAW molten pool`、`narrow gap welding`、`arc oscillation`
- 时间范围：近 10 年；来源：arXiv、MDPI、Elsevier、Springer

## 2. AI 检索

在 TRAE 中让 AI 检索候选文献：

```
请检索 2020 年以来关于 narrow-gap GTAW molten pool 的文献，
列出标题、作者、年份、来源和 DOI，输出为表格。
```

AI 会综合使用 Web 检索与数据库查询，汇总候选列表。

## 3. 筛选排序

按以下维度筛选：

- 相关性：是否直接对应研究问题
- 质量：期刊分区 / 会议级别 / 被引次数
- 可获取性：是否可通过机构订阅、个人渠道或开放获取途径获取

AI 输出推荐下载清单。

## 4. 自动下载

通过浏览器自动化批量下载 PDF：

```
请打开 https://arxiv.org/pdf/xxxx.xxxxx，下载 PDF 到 D:\literature\downloads\
```

支持的去重策略：按文件名 / 内容哈希（SHA-256）去重，避免重复下载。

> 不局限于开放获取：对于非 OA 文献，可通过机构订阅（校园网 / VPN / 图书馆代理）、个人已购渠道或作者主页等合法途径获取全文；浏览器自动化会沿用当前登录会话完成下载。

## 5. Zotero 入库

将 PDF 导入 Zotero 并抓取元数据：

```
请将 D:\literature\downloads\ 中所有 PDF 导入 Zotero，
自动抓取标题、作者、期刊、年份、DOI。
```

## 6. 分类整理

按主题创建 Collections 并移动条目：

```
请创建 Collection "GTAW/molten-pool"，并将相关条目移入；
同主题文献按年份建立子 Collection 或使用标签（Tags）管理。
```

推荐组织方式：

```
My Library/
├── GTAW/
│   ├── narrow-gap
│   ├── molten-pool
│   └── wire-oscillation
├── AMF-welding/
└── Reviews/
```

## 7. 同步备份

- Zotero 云同步：条目 + 附件上传到 Zotero 云端。
- 本地备份：定期将 Zotero 数据目录复制到外部存储（脚本示例见 `config/sync.example.ps1`）。
- 验证：同步完成后核对云端条目数与本地一致。

## 审计与复现

所有 AI 操作以对话记录保留；关键脚本（下载、导入、同步）保存在本仓库，可一键复现整条流水线。
