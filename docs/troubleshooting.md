# Troubleshooting / 排错手册
常见问题与解决方案。按「症状 → 原因 → 处理」组织。
## 1. Zotero 相关
### 1.1 Zotero 未启动导致 MCP 调用失败
- 症状：所有 `zotero_*` 工具返回连接错误或超时。
- 原因：Zotero 桌面端未运行，本地 API（`127.0.0.1:23119`）不可用。
- 处理：启动 Zotero，等待主窗口加载完成后再重试。
### 1.2 条目搜不到
- 症状：搜索关键词返回空结果，但文献库中明显存在该条目。
- 原因 1：搜索范围错误（如只在某 Collection 内搜索）。
- 原因 2：官方 API 模式下 Key 权限不足。
- 处理：确认搜索范围；检查 `ZOTERO_API_KEY` 与 `ZOTERO_USER_ID`；尝试用标题精确匹配。
### 1.3 附件（PDF）挂载失败
- 症状：`zotero_attach_file` 报错或附件为空。
- 原因：路径含中文、空格或特殊字符；文件被占用（已在 PDF 阅读器中打开）。
- 处理：使用绝对路径；关闭占用程序；先复制到临时目录再挂载。
### 1.4 同步后条目丢失/重复
- 症状：云端条目与本地不一致，或出现重复条目。
- 原因：多端同时修改产生冲突；同步未完成即关闭 Zotero。
- 处理：在单端完成修改后再同步；使用 `zotero_find_duplicates` 检测重复并 `zotero_merge_duplicates` 合并；确认同步完成再退出 Zotero。
### 1.5 MCP 写操作偶发断连（WinError 10054 / SSL 握手超时）
- 症状：`zotero_*` 写操作报 `_ssl.c:993 handshake timed out` 或 `WinError 10054 远程主机强迫关闭`。
- 原因：本地 API 连接不稳定，偶发中断。
- 处理：**仅对失败条目重试即可**，其余成功的不动，勿判整体失败。
### 1.6 API 写入被拒（WinError 10061）
- 症状：条目写入路径被连接拒绝，无法入库。
- 原因：本地 API 未就绪/连接被拒。
- 处理：降级为**离线 BibTeX 交付**（经 CrossRef DOI 解析批量生成）供手动导入，不影响交付；完成后仍可尝试补录。
### 1.7 link 型附件无法读全文
- 症状：`zotero_get_item_fulltext` 取不到文本。
- 原因：附件是 link 型，无本地副本。
- 处理：将 PDF 复制进 Zotero storage 目录并重新挂载后即可精读。

## 2. 浏览器自动化下载相关
### 2.1 下载被验证码/风控拦截
- 症状：打开 PDF 页面后出现验证码、人机验证。
- 原因：目标网站（如某些出版社）启用反爬风控。
- 处理：改用机构订阅渠道；放慢下载频率；对 OA 期刊使用官方开放接口；Cloudflare 反爬严重（Hindawi/部分 SEI）时可评估直接排除。
### 2.2 下载了重复文件
- 症状：同一文献被下载多次，磁盘出现 `xxx (1).pdf`。
- 原因：未做去重。
- 处理：按 SHA-256 内容哈希去重；入库前检查 Zotero 中是否已有同 DOI 条目；下载后清理 ` (n)` 后缀文件。
### 2.3 下载文件损坏（0 KB 或打不开）
- 症状：PDF 无法打开，文件大小异常。
- 原因：页面跳转未完成即保存；需带 Referer 下载。
- 处理：等待页面完全加载；从浏览器内触发下载而非裸 URL；校验文件头 `%PDF`。
### 2.4 MDPI 直接请求 403
- 症状：直接访问 `/pdf` 返回 Cloudflare 403。
- 原因：无会话 Cookie。
- 处理：先访问文章页建立会话，再触发 `/pdf?version=xxx` 下载。
### 2.5 ScienceDirect 内嵌 PDF 被拦
- 症状：内嵌 PDF 无法直接下载。
- 处理：用 `?download=true` 或 `pdfft` 端点，必要时对下载请求附加 `Content-Disposition: attachment`。
### 2.6 下载目录非默认
- 症状：找不到下载的文件。
- 原因：浏览器下载路径被改（如 `F:\BaiduNetdiskDownload`）。
- 处理：先探测真实下载目录再定位/清理文件。

## 3. GitHub / 上传相关
### 3.1 推送被拒（403 Resource not accessible）
- 症状：`POST /user/repos` 或 push 返回 403。
- 原因：Fine-grained PAT 缺少对应权限。
- 处理：
  - 创建仓库需 `Administration: write`（响应头 `X-Accepted-GitHub-Permissions: administration=write`）。
  - 读写代码需 `Contents: Read and write`。
  - 在 `Settings → Developer settings → Fine-grained tokens` 中调整后重试。
### 3.2 push 提示认证失败
- 症状：`remote: Invalid username or token`。
- 原因：Token 过期、被撤销或权限变更。
- 处理：重新生成 token；确认仓库访问范围包含目标仓库；使用 `gh auth login` 或 HTTPS + token 方式。

## 4. 网络与代理
### 4.1 GitHub / 出版社访问慢或超时
- 原因：网络环境限制。
- 处理：配置代理；为 git 设置代理（`git config --global http.proxy`）；重试。
### 4.2 同步/下载偶发中断
- 处理：断点重试；对大批量任务分批执行；记录已处理清单以便续跑。

## 5. 常见错误码速查
| 错误码 | 含义 | 处理 |
| --- | --- | --- |
| 403 | 权限不足/风控 | 检查 token 权限；等待风控解除 |
| 404 | 资源不存在 | 检查仓库名/路径/条目 ID |
| 409 | 冲突（已存在） | 用 update 而非 create |
| 422 | 参数校验失败 | 检查请求体字段 |
| 429 | 限流 | 等待或降低频率 |
| 10054 | 连接被远端强制关闭 | 重试该条目 |
| 10061 | 连接被拒 | 检查本地 API 是否就绪；回退 BibTeX |
