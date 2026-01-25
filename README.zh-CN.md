# Everything Cursor - 中文说明

**Cursor AI 完整配置集合 - 规则、技能、智能体、命令、钩子和 MCP 配置**

基于 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 项目改编，适用于 Cursor IDE。

---

## 项目用途

这是一套**可复用的 Cursor AI 配置模板**，包含：

- ✅ **Rules（规则）** - AI 必须遵守的编码规范和安全准则
- ✅ **Skills（技能）** - 领域知识和工作流定义
- ✅ **Agents（智能体）** - 专项任务的子代理
- ✅ **Commands（命令）** - 快捷 Slash 命令
- ✅ **Hooks（钩子）** - 自动化检查和操作
- ✅ **MCP Configs** - 外部工具集成配置

---

## 可以复用吗？

**是的，完全可以复用到任何项目中！** 

这些配置是通用的开发最佳实践，适用于：

| 项目类型 | 适用性 |
|---------|--------|
| React/Next.js 前端项目 | ✅ 完全适用 |
| Node.js 后端项目 | ✅ 完全适用 |
| TypeScript 项目 | ✅ 完全适用 |
| Python 项目 | ⚠️ 部分适用（规则通用，代码示例需调整） |
| 其他语言项目 | ⚠️ 规则和流程通用，代码示例需调整 |

---

## 快速安装

### 方法一：复制到项目（推荐）

```bash
# 克隆配置仓库
git clone https://github.com/YOUR_USERNAME/everything-cursor.git

# 复制 .cursor 目录到你的项目
cp -r everything-cursor/.cursor 你的项目路径/.cursor
```

### 方法二：全局安装

```bash
# Windows (PowerShell)
xcopy everything-cursor\.cursor $env:USERPROFILE\.cursor /E /I

# macOS/Linux
cp -r everything-cursor/.cursor ~/.cursor
```

### 方法三：按需复制

只复制你需要的部分：

```bash
# 只复制规则
cp -r everything-cursor/.cursor/rules 你的项目/.cursor/rules

# 只复制技能
cp -r everything-cursor/.cursor/skills 你的项目/.cursor/skills

# 只复制命令
cp -r everything-cursor/.cursor/commands 你的项目/.cursor/commands
```

---

## 目录结构

```
.cursor/
├── agents/               # 专项智能体（9个）
│   ├── planner.md           # 功能规划和任务分解
│   ├── architect.md         # 系统设计和技术选型
│   ├── code-reviewer.md     # 代码质量审查
│   ├── security-reviewer.md # 安全漏洞分析
│   ├── build-error-resolver.md  # 构建错误修复
│   ├── e2e-runner.md        # E2E 测试生成
│   ├── refactor-cleaner.md  # 死代码清理
│   ├── doc-updater.md       # 文档同步
│   └── tdd-guide.md         # TDD 工作流指导
│
├── skills/               # 技能库（5个）
│   ├── tdd-workflow/        # 测试驱动开发方法论
│   ├── coding-standards/    # 代码质量标准
│   ├── security-review/     # 安全审计清单
│   ├── backend-patterns/    # 后端模式（API、数据库、缓存）
│   └── frontend-patterns/   # 前端模式（React、Next.js）
│
├── commands/             # Slash 命令（8个）
│   ├── tdd.md               # /tdd - 测试驱动开发
│   ├── plan.md              # /plan - 实现规划
│   ├── e2e.md               # /e2e - E2E 测试生成
│   ├── code-review.md       # /code-review - 代码审查
│   ├── build-fix.md         # /build-fix - 修复构建错误
│   ├── refactor-clean.md    # /refactor-clean - 清理死代码
│   ├── security-audit.md    # /security-audit - 安全审计
│   └── doc-sync.md          # /doc-sync - 文档同步
│
├── rules/                # 核心规则（7个，.mdc 格式）
│   ├── security.mdc         # 安全准则
│   ├── coding-style.mdc     # 代码风格
│   ├── testing.mdc          # 测试规范
│   ├── git-workflow.mdc     # Git 工作流
│   ├── patterns.mdc         # 设计模式
│   ├── performance.mdc      # 性能优化
│   └── workflow.mdc         # 开发流程
│
├── hooks/                # 自动化钩子
│   ├── hooks.json           # 钩子配置
│   └── README.md            # 钩子说明
│
├── mcp-configs/          # MCP 配置模板
│   ├── full-stack.json      # 全栈开发配置
│   └── minimal.json         # 最小化配置
│
└── mcp.json              # 默认 MCP 配置
```

---

## 六大核心模块详解

### 1. Agents（专项智能体）

**作用**：将复杂任务委托给专门的子代理处理，实现精细分工。

| 智能体 | 职责 |
|--------|------|
| `planner` | 需求拆解、任务分解、进度规划 |
| `architect` | 系统设计、技术选型、架构决策 |
| `code-reviewer` | 代码质量审查、最佳实践检查 |
| `security-reviewer` | 安全漏洞检测、风险评估 |
| `build-error-resolver` | 构建错误诊断和修复 |
| `e2e-runner` | Playwright E2E 测试生成 |
| `refactor-cleaner` | 死代码识别和清理 |
| `doc-updater` | 文档同步更新 |
| `tdd-guide` | TDD 流程指导 |

**使用方式**：在 Cursor 中引用 `@agents/planner` 来调用对应智能体。

---

### 2. Skills（技能库）

**作用**：注入领域知识，统一代码风格，让 AI 生成的代码符合指定技术栈的最佳实践。

| 技能 | 内容 |
|------|------|
| `tdd-workflow` | RED → GREEN → REFACTOR 测试驱动开发流程 |
| `coding-standards` | 代码质量标准、命名规范、错误处理 |
| `security-review` | 安全审计清单、漏洞检测方法 |
| `backend-patterns` | API 设计、数据库模式、缓存策略、认证授权 |
| `frontend-patterns` | React 组件模式、状态管理、性能优化 |

**使用方式**：在 Cursor 中引用 `@skills/backend-patterns` 来加载对应技能。

---

### 3. Commands（快捷指令）

**作用**：将复杂流程封装为一键操作，从"对话式编程"升级为"指令式工程流"。

| 命令 | 功能 |
|------|------|
| `/tdd` | 执行完整 TDD 流程：定义接口 → 写测试 → 实现 → 重构 |
| `/plan` | 创建详细的实现计划和任务分解 |
| `/e2e` | 生成 Playwright E2E 测试用例 |
| `/code-review` | 执行代码质量审查 |
| `/build-fix` | 诊断并修复构建错误 |
| `/refactor-clean` | 识别并清理死代码 |
| `/security-audit` | 执行安全漏洞扫描 |
| `/doc-sync` | 同步文档与代码变更 |

---

### 4. Rules（核心规则）

**作用**：AI 必须遵守的底线与红线，不仅是建议，而是强制约束。

| 规则 | 要求 |
|------|------|
| `security.mdc` | 禁止硬编码密钥、强制输入验证、防止注入攻击 |
| `coding-style.mdc` | 不可变性、文件 ≤800 行、函数 ≤50 行、无 any 类型 |
| `testing.mdc` | TDD 流程、80% 测试覆盖率 |
| `git-workflow.mdc` | Conventional Commits 格式、PR 流程 |
| `patterns.mdc` | API 响应格式、Repository 模式、Result 模式 |
| `performance.mdc` | 性能优化、缓存策略、懒加载 |
| `workflow.mdc` | 开发流程：规划 → TDD → 审查 → 提交 |

**重要**：Rules 文件必须使用 `.mdc` 扩展名并包含 YAML frontmatter 才能被 Cursor 识别。

---

### 5. MCP Configs（工具集成）

**作用**：打通工具链，实现 IDE ↔ 代码仓库 ↔ 部署平台 ↔ AI 的无缝交互。

| 服务 | 功能 |
|------|------|
| `github` | 直接读取 Issue、提交 PR、仓库操作 |
| `memory` | 跨会话持久化记忆 |
| `context7` | 实时文档查询 |
| `supabase` | 数据库操作 |
| `vercel` | 部署管理 |
| `playwright` | 浏览器自动化 |

**注意**：不要同时启用所有 MCP，会占用过多上下文窗口。建议每个项目启用 ≤10 个。

---

### 6. Hooks（自动化钩子）

**作用**：工程细节的自动守门员，把容易遗漏的检查交给系统自动完成。

| 钩子 | 触发时机 | 作用 |
|------|----------|------|
| `no-console-log` | 提交前 | 检查是否有 console.log 残留 |
| `no-hardcoded-secrets` | 提交前 | 检测硬编码的密钥 |
| `lint-check` | 编辑后 | 自动运行 ESLint |
| `format-check` | 编辑后 | 自动运行 Prettier |
| `type-check` | 生成后 | 运行 TypeScript 类型检查 |

---

## 自定义配置

这些配置是起点，你应该根据自己的需求调整：

### 1. 调整测试覆盖率要求

编辑 `.cursor/rules/testing.mdc`：

```yaml
# 将 80% 改为你需要的值
coverage: 70%
```

### 2. 调整文件大小限制

编辑 `.cursor/rules/coding-style.mdc`：

```yaml
# 将 800 行改为你需要的值
max_file_lines: 500
```

### 3. 添加自定义 Commit 类型

编辑 `.cursor/rules/git-workflow.mdc`：

```markdown
### 自定义类型
- `perf`: 性能优化
- `i18n`: 国际化
```

### 4. 启用/禁用 MCP 服务器

编辑 `.cursor/mcp.json`：

```json
{
  "disabledMcpServers": ["supabase", "vercel"]
}
```

---

## 使用建议

### 适合的用户

| 用户类型 | 推荐使用方式 |
|----------|-------------|
| **技术负责人** | 降低 Code Review 成本，提升团队代码基线 |
| **独立开发者** | 获得成熟工程团队的开发流程 |
| **AI 编程爱好者** | 将 AI 编程推向生产级应用 |

### Token 消耗提示

⚠️ 这套配置包含了大量上下文规则和知识，会增加 Token 消耗：

- 建议根据项目实际需求，**选择性地加载** Agents 和 Skills
- 在并发任务中，可以暂时禁用部分重复配置以节省成本

---

## 常见问题

### Q: 为什么 Cursor 没有识别我的规则？

**A**: Rules 文件必须满足：
1. 使用 `.mdc` 扩展名（不是 `.md`）
2. 文件开头包含 YAML frontmatter：

```yaml
---
description: 规则描述
globs: 
alwaysApply: true
---
```

### Q: 如何在新项目中使用这些配置？

**A**: 只需将 `.cursor` 目录复制到你的项目根目录即可。

### Q: 可以只使用部分功能吗？

**A**: 完全可以。每个模块都是独立的，你可以只复制需要的目录。

---

## 项目来源

基于 [everything-claude-code](https://github.com/affaan-m/everything-claude-code) 改编：

- 原项目作者：[@affaanmustafa](https://x.com/affaanmustafa)
- Anthropic x Forum Ventures 黑客松冠军
- 25.9k+ GitHub Stars

---

## 许可证

MIT - 自由使用、修改，欢迎贡献回馈。

---

**如果这个项目对你有帮助，请给个 Star！用 Cursor 构建伟大的东西！**
