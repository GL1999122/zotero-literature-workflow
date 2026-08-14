# 完整工作流 · 单次提示词

在新开 TRAE 项目中粘贴以下内容，即可启动完整工作流。

---

```
请执行一次完整的文献检索 → 筛选 → 下载 → Zotero 入库 → 分类 → 同步工作流。

【演示主题】窄间隙钨极氩弧焊（Narrow-Gap GTAW）中的熔池行为
【下载目录】D:\literature\downloads\（不存在则先创建）

请严格按以下顺序执行，每步完成并确认后再进行下一步：

第 0 步 · 环境确认
确认 Zotero MCP 工具已加载（zotero_search_items、zotero_add_by_doi、
zotero_attach_file、zotero_create_collection、zotero_batch_update_tags 等），
并确认 Zotero 正在运行。

第 1 步 · 检索
检索 2020 年以来关于该主题的文献，综合使用 Web 搜索与数据库查询，
输出候选文献表格（标题 / 作者 / 年份 / 来源 / DOI / 链接）。

第 2 步 · 筛选
从候选中筛出与主题直接相关、且能获取全文的 10 篇，给出下载清单。
注意：不限于开放获取文献，机构订阅可访问的同样纳入。

第 3 步 · 浏览器下载
对清单中的每篇文献，用浏览器自动化（agent-browser）打开 PDF 页面，
保存到下载目录。每下载一篇就展示一次目录新增文件，再继续下一篇。
某篇下载失败时说明原因并跳过，不中断流程。

第 4 步 · Zotero 入库
用 Zotero MCP 将下载的 PDF 导入 Zotero：
- 用 zotero_add_by_doi（或 zotero_add_by_url）创建条目，自动抓取元数据；
- 用 zotero_attach_file 将 PDF 挂载为附件；
- 全部完成后打开 Zotero 界面，展示新条目列表。

第 5 步 · 分类整理
用 zotero_create_collection 创建分类层级 "GTAW/molten-pool"，
将相关条目移入，并用 zotero_batch_update_tags 添加标签 "ng-gtaw"。

第 6 步 · 同步确认
触发 Zotero 同步，核对条目与附件已同步到云端。
```

---

## 分步版（适合分环节演示）

如果希望分步执行、每步讲解后再继续，可拆成 6 条独立指令：

| 步骤 | 指令 |
|------|------|
| ① 检索 | 检索 2020 年以来关于 narrow-gap GTAW molten pool 的文献，列出标题、作者、年份、来源和 DOI，输出为表格。 |
| ② 筛选 | 请从上面结果中筛选出与熔池行为直接相关的 10 篇，给出下载清单（含标题、DOI、下载链接）。注意：不限于开放获取，机构订阅可访问的同样纳入。 |
| ③ 下载 | 请用浏览器逐篇打开下载清单中的 PDF 页面，下载到 D:\literature\downloads\。每下载一篇展示一次目录，再继续下一篇。 |
| ④ 入库 | 请将 D:\literature\downloads\ 中所有 PDF 导入 Zotero，用 zotero_add_by_doi 创建条目并自动抓取元数据，用 zotero_attach_file 挂载附件。 |
| ⑤ 分类 | 请在 Zotero 中创建 Collection "GTAW/molten-pool"，将相关条目移入，并添加标签 "ng-gtaw"。 |
| ⑥ 同步 | 请检查 Zotero 同步状态，确认条目与附件已同步到云端。 |

## 一命令版（适合快速验证）

如果只想快速跑通核心链路，用一句话即可：

```
请检索 narrow-gap GTAW 熔池行为相关文献，筛选 3 篇能获取全文的，
用浏览器下载到 D:\literature\downloads\，再用 Zotero MCP 导入并分类。
不限于开放获取，机构订阅可访问的同样纳入。
```