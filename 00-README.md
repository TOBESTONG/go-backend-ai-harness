# Go Backend AI Harness

这是一套面向新公司 Mac 环境的个人 AI IDE harness。目标是帮助 Go 后端新人度过 landing 期：更快读懂仓库、更稳地做小改动、更清楚地向同事和模型交代上下文，同时避免把个人偏好、外部工具和公司安全边界混在一起。

## 使用原则

- 公司安全、合规和团队规范优先于本目录内所有规则。
- 入职后先确认公司是否允许使用 AI IDE、允许哪些模型、哪些代码和日志可以进入模型上下文、哪些连接器或 MCP 可以启用。
- 不把 Secrets、Token、私钥、Cookie、数据库密码、生产日志原文、用户隐私数据或内部凭据放入 AI 对话、规则文件、提交信息或公开文档。
- 先本地个人使用，再根据团队反馈沉淀到项目。不要一入职就把模板提交到公司仓库。

## 目录结构

```text
go-backend-ai-harness/
├─ 00-README.md
├─ personal-runtime/
│  ├─ AGENTS.md
│  └─ agents/
│     ├─ file-handling.md
│     └─ reply.md
├─ repo-overlay/
│  └─ AGENTS.md
├─ landing-workbench/
│  └─ LANDING.md
├─ tool-adapters/
│  ├─ README.md
│  ├─ claude/
│  │  └─ CLAUDE.md
│  ├─ cursor/
│  │  └─ go-backend.mdc
│  ├─ trae/
│  │  └─ rules.md
│  └─ copilot/
│     └─ copilot-instructions.md
└─ playbooks/
   └─ go-backend.md
```

## 部署方式

### 1. 个人全局规则

将 `personal-runtime/AGENTS.md`、`personal-runtime/agents/reply.md` 和 `personal-runtime/agents/file-handling.md` 放入 AI IDE 支持的个人规则目录。对于 Codex 风格配置，可以放成：

```text
~/.codex/AGENTS.md
~/.codex/agents/file-handling.md
~/.codex/agents/reply.md
```

如果公司 AI IDE 使用其他文件名，例如 `CLAUDE.md`、`GEMINI.md` 或自定义 user instructions，将 `personal-runtime/AGENTS.md` 的内容复制到对应入口即可。

### 2. 项目覆盖模板

`repo-overlay/AGENTS.md` 是项目级模板。只有在确认团队允许项目规则文件后，才复制到公司仓库根目录，并把占位内容改成真实的仓库命令、目录职责和完成标准。

### 3. Landing 工作台

`landing-workbench/LANDING.md` 是个人笔记，不建议提交。它用于记录业务边界、服务链路、常用命令、PR 反馈和同事口头经验。

### 4. Go 后端流程手册

`playbooks/go-backend.md` 是手动触发的工作手册。遇到读仓、做需求、调试、PR 自查时，让 AI 先参考这个文件，再开始具体任务。

### 5. 其他 AI IDE 适配器

`tool-adapters/` 提供 Claude Code、Cursor、Trae 和 GitHub Copilot 的入口模板。它们不是新的规则源头，只是把 `personal-runtime/`、`repo-overlay/` 和 `playbooks/` 的核心原则映射到不同工具。

具体用法见 `tool-adapters/README.md`。

### 6. 可选 skill：Ponytail

`Ponytail` 是一个优秀的极简工程 skill，适合在新环境中按公司规则确认后安装。它的核心思想已经吸收到本 harness：先判断需求是否真实存在，再复用代码库已有实现，再使用标准库、平台能力和已安装依赖，最后才写最小代码。

如果公司 AI IDE 允许安装外部 skill 或插件，可以安装原版 `DietrichGebert/ponytail`。安装前确认：外部插件是否合规、是否需要 Node.js lifecycle hooks、是否会把上下文发送到未批准的服务。

## 日常节奏

1. 先读上下文：README、构建脚本、CI、相关代码、测试和调用方。
2. 再明确目标：要改什么、不改什么、验收标准是什么。
3. 选择最小可行方案：复用已有实现优先于新增代码，标准库和平台能力优先于新依赖。
4. 小范围修改：遵循现有分层、命名、错误处理、日志和测试风格。
5. 运行验证：优先项目已有命令；Go 项目常见候选包括 `go test ./...`、`go vet ./...`、`golangci-lint run`。
6. 最后复盘：说明实际修改、验证结果、未覆盖风险和需要同事确认的点。

## 维护方式

landing 期每周回看一次本目录。只有当某条规则反复帮到你，才沉淀进 `AGENTS.md`；只出现一次的问题，先记在 `LANDING.md`，不要过早固化成规则。
