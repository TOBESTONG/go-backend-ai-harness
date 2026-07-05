# Git Workflow Playbook

这个文件用于手动触发，不是每次对话都必须执行。公司团队规范优先于本文件；如果团队使用 trunk-based、Git Flow、merge commit、squash merge 或其他策略，按团队规范执行。

## 1. 分支策略

目标：让 SourceTree、Git 图和 PR/MR 历史保持清晰。

- 从最新目标分支创建短生命周期功能分支，目标分支通常是 `main`、`master`、`dev` 或团队指定分支。
- 一个需求、一个修复或一个实验对应一个分支；不要长期使用万能个人分支。
- 分支名表达任务，不只写人名。
- 多人共享分支不要随意 rebase 和强推；个人独占功能分支可以 rebase。
- 合并后删除本地和远程功能分支。

分支名示例：

```text
feature/sql-image-opt
fix/order-timeout
perf/model-query
docs/onboarding
zhangweibo/sql-image-opt
```

## 2. 开始一个功能分支

以 `dev` 为目标分支时：

```bash
git switch dev
git pull --ff-only origin dev
git switch -c feature/sql-image-opt
```

如果仓库默认分支是 `main`：

```bash
git switch main
git pull --ff-only origin main
git switch -c feature/sql-image-opt
```

`--ff-only` 可以避免本地目标分支产生意外 merge commit。如果失败，先查看原因，不要立刻强行重置。

## 3. 日常提交

提交前先看状态：

```bash
git status
git diff
git diff --staged
```

优先精确添加文件：

```bash
git add <path>
```

需要拆分提交时使用：

```bash
git add -p
```

少用 `git add .`。只有确认当前目录下所有改动都属于本次提交时再使用。

提交信息建议参考 Conventional Commits：

```text
type(scope): subject
```

常用类型：

```text
feat: 新功能
fix: 修复 bug
perf: 性能优化
refactor: 重构，不改变外部行为
test: 测试
docs: 文档
chore: 构建、工具、杂项维护
```

示例：

```bash
git commit -m "perf(app/model/image): 优化机器关联镜像 SQL"
git commit -m "fix(order): handle timeout retry"
git commit -m "test(user): cover invalid token case"
```

## 4. 同步目标分支

个人独占功能分支可按团队规范 rebase 到最新目标分支：

```bash
git fetch origin
git rebase origin/dev
```

如果目标分支是 `main`：

```bash
git fetch origin
git rebase origin/main
```

多人共享分支不要随意 rebase 或强推。团队要求 merge commit、squash merge 或禁止强推时，按团队规范执行。

冲突处理：

```bash
# 修改冲突文件后
git add <conflict-file>
git rebase --continue
```

如果发现方向错了：

```bash
git rebase --abort
```

## 5. 推送

首次推送：

```bash
git push -u origin feature/sql-image-opt
```

普通后续推送：

```bash
git push
```

rebase 后需要改写远程个人分支时：

```bash
git push --force-with-lease
```

不要使用裸 `git push -f`。`--force-with-lease` 会在推送前检查远程分支是否被别人更新，能降低覆盖他人提交的风险。

## 6. PR / MR 前自查

查看自己的提交：

```bash
git log --oneline --graph origin/dev..HEAD
```

查看准备进入 PR/MR 的改动：

```bash
git diff origin/dev...HEAD
```

如果目标分支是 `main`，把 `origin/dev` 替换为 `origin/main`。

自查清单：

- 当前分支是否是功能分支，而不是 `dev` / `main`。
- `git status` 是否干净。
- 提交是否只包含本次需求相关改动。
- 是否混入格式化、临时文件、日志、`.env` 或私人笔记。
- 是否已经 rebase 到最新目标分支，或按团队要求 merge 目标分支。
- 是否运行了与风险匹配的测试、lint 或构建命令。
- PR/MR 描述是否包含背景、修改、验证、风险和回滚。

## 7. SourceTree 整洁原则

- 使用短生命周期功能分支。
- 提交粒度保持小而完整，一次提交只表达一个意图。
- 合并前整理个人分支历史；不要整理多人共享分支历史。
- 合并后删除已完成分支。
- 不把多个需求堆在同一个长期个人分支上。
- 不把无关重构、格式化和功能修改混在同一次 PR/MR 中。

## 8. 需要停下来确认的信号

- 不确定团队目标分支是 `dev`、`main` 还是 release 分支。
- 分支已经被多人共同使用。
- rebase 后出现大量冲突，且涉及不熟悉模块。
- 需要强推但不确定远程是否有他人提交。
- PR/MR 里出现与任务无关的大量 diff。
- SourceTree 图已经显示异常 merge、重复提交或分支方向不清。

## 参考

- GitHub Flow: https://docs.github.com/en/get-started/using-github/github-flow
- Git push `--force-with-lease`: https://git-scm.com/docs/git-push
- Conventional Commits: https://www.conventionalcommits.org/en/v1.0.0/
- Atlassian Git rebase tutorial: https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase
