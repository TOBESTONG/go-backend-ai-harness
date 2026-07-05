# Tool Adapters

本目录把同一套 harness 映射到不同 AI 编程工具。它不是新的规则源头。

## Source of Truth

- 个人全局规则：`../personal-runtime/AGENTS.md`
- 回复与信任边界：`../personal-runtime/agents/reply.md`
- 文件处理细则：`../personal-runtime/agents/file-handling.md`
- 项目级模板：`../repo-overlay/AGENTS.md`
- Go 后端流程：`../playbooks/go-backend.md`

如果不同工具的适配文件和上面源文件冲突，优先更新源文件，再同步适配文件。

## Claude Code

复制：

```bash
mkdir -p ~/.claude
cp tool-adapters/claude/CLAUDE.md ~/.claude/CLAUDE.md
```

如果项目仓库支持共享规则，可以在仓库根目录放 `CLAUDE.md`，并按团队规范裁剪。

## Cursor

个人规则：将 `../personal-runtime/AGENTS.md` 的内容放到 Cursor User Rules。

项目规则：复制：

```bash
mkdir -p .cursor/rules
cp tool-adapters/cursor/go-backend.mdc .cursor/rules/go-backend.mdc
```

提交到公司仓库前，先确认团队允许项目级 AI 规则文件。

## Trae

个人 Rules：复制或粘贴 `tool-adapters/trae/rules.md`。

项目 Rules：以 `../repo-overlay/AGENTS.md` 为源头，裁剪成团队认可的项目规则。

## GitHub Copilot

项目规则：复制：

```bash
mkdir -p .github
cp tool-adapters/copilot/copilot-instructions.md .github/copilot-instructions.md
```

Copilot 指令进入公司仓库前，必须删掉占位项并填入真实命令；不允许把内部敏感信息写入公开仓库。
