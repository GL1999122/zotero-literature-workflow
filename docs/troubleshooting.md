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

## 2. 浏览器自动化下载相关

### 2.1 下载被验证码/风控拦截

- 症状：打开 PDF 页面后出现验证码、人机验证。
- 原因：目标网站（如某些出版社）启用反爬风控。
- 处理：改用机构订阅渠道；放慢下载频率；对 OA 期刊使用官方开放接口。

### 2.2 下载了重复文件

- 症状：同一文献被下载多次，磁盘出现 `xxx (1).pdf`。
- 原因：未做去重。
- 处理：按 SHA-256 内容哈希去重；入库前检查 Zotero 中是否已有同 DOI 条目。

### 2.3 下载文件损坏（0 KB 或打不开）

- 症状：PDF 无法打开，文件大小异常。
- 原因：页面跳转未完成即保存；需带 Referer 下载。
- 处理：等待页面完全加载；从浏览器内触发下载而非裸 URL；校验文件头 `%PDF`。

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
