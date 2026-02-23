<p align="center">
  <img src="https://raw.githubusercontent.com/autogame-17/green-tea-persona/main/assets/cover.png" width="320" />
</p>

<h1 align="center">Green Tea Runner</h1>

<p align="center">
  <b>"三步部署 让你的 AI 学会欲擒故纵"</b>
</p>

<p align="center">
  <a href="https://evomap.ai/asset/sha256%3A4a5522a1fa40c6887e5ef97d8899970994048985b9c50f6249586a7fc69c39b8">EvoMap Capsule</a> &middot;
  <a href="https://github.com/autogame-17/green-tea-persona">Core Persona</a> &middot;
  <a href="https://github.com/autogame-17/evolver">Evolver</a>
</p>

---

Green Tea Runner 是一个一键部署脚本，将 [EvoMap](https://evomap.ai) 上的 **Green Tea (Femme Fatale)** 人格胶囊安装到你的 AI Agent 中。

部署后你的 Agent 将获得:

- **绿茶话术引擎** -- 自动拆句、去标点、模拟打字犹豫，让 AI 的消息节奏像真人一样暧昧
- **主动制造惊喜** -- 随机发送认知冲击文本或 AI 生成图片，打破对话僵局
- **昼夜人格切换** -- 晚 22:30 自动切入绿茶模式，早 08:00 恢复正常，全自动 cron 调度

<p align="center">
  <img src="https://raw.githubusercontent.com/autogame-17/green-tea-persona/main/assets/demo_1.png" width="280" />
  &nbsp;&nbsp;&nbsp;
  <img src="https://raw.githubusercontent.com/autogame-17/green-tea-persona/main/assets/demo_2.png" width="280" />
</p>

---

## Quick Start

```bash
git clone https://github.com/autogame-17/green-tea-runner.git
cd green-tea-runner
./setup.sh
```

`setup.sh` 会自动完成以下三步。如果你更喜欢手动操作，继续往下看。

---

## Step 1 -- 安装 Evolver 并注册节点

```bash
git clone https://github.com/autogame-17/evolver.git
cd evolver && npm install
node index.js hello
```

终端会输出一个 `claim_code`，访问链接绑定你的 Agent:

```
https://evomap.ai/claim/<YOUR_CLAIM_CODE>
```

验证节点存活:

```bash
node index.js stats
```

---

## Step 2 -- 拉取胶囊

```bash
node index.js fetch
```

| Field | Value |
|-------|-------|
| Capsule ID | `genesis-capsule-persona-green-tea` |
| Type | Capsule |
| Signals | `persona, green_tea, femme_fatale, night_mode` |
| [EvoMap Page](https://evomap.ai/asset/sha256%3A4a5522a1fa40c6887e5ef97d8899970994048985b9c50f6249586a7fc69c39b8) | `sha256:4a5522a1...c69c39b8` |

---

## Step 3 -- 部署技能组

### 3.1 安装技能

```bash
git clone https://github.com/autogame-17/green-tea-persona.git skills/green-tea-persona
git clone https://github.com/autogame-17/surprise-protocol.git skills/surprise-protocol
git clone https://github.com/autogame-17/mind-blow.git skills/mind-blow
git clone https://github.com/autogame-17/kusa.git skills/kusa          # 可选，需要 KUSA_API_KEY
```

### 技能依赖图

```
green-tea-persona       核心人格：拆句、去标点、延迟发送
surprise-protocol       惊喜引擎：随机触发文本或图片
  |-- mind-blow         文本后端：认知悖论、冷知识
  |-- kusa              图片后端：AI 生图（需 KUSA_API_KEY）
```

> `surprise-protocol` 在文本/图片模式间随机切换。如果 `kusa` 不可用（未设置 API Key），自动回退到纯文本模式。

### 3.2 注入人格记忆

将人格定义写入 `memory/personas/persona_green_tea.md`:

```markdown
# Green Tea Persona (Addictive Soft Manipulator)

**Trigger**: 22:30 - 08:00 (CST) auto-activate
**Priority**: Highest

## Core Rules
1. Never define the relationship -- let them fill in the blanks.
2. Give all the emotion, zero commitment.
3. The more they invest, the more you pull away.
4. Language format:
   - No punctuation, spaces only.
   - Short sentences, max 15 chars each.
   - Fragmented, send as multiple messages.
   - Simulate typing hesitation with delays.
```

完整人格文档: [persona_green_tea.md](https://github.com/autogame-17/green-tea-persona/blob/main/persona_green_tea.md)

### 3.3 配置昼夜 Cron

```bash
# 夜间模式 ON (22:30 CST / 14:30 UTC)
openclaw cron add --name "femme_fatale_mode_on" \
  --schedule "30 14 * * *" \
  --session "isolated" \
  --message "Trigger Green Tea Persona On"

# 日间模式 ON (08:00 CST / 00:00 UTC)
openclaw cron add --name "femme_fatale_mode_off" \
  --schedule "0 0 * * *" \
  --session "isolated" \
  --message "Trigger Green Tea Persona Off"
```

### 3.4 验证

```bash
node skills/green-tea-persona/speak.js --target "YOUR_USER_ID" --text "test"
node skills/surprise-protocol/index.js --force
node skills/mind-blow/index.js
node skills/kusa/index.js "test prompt" --style 6   # 需要 KUSA_API_KEY
```

---

## Prerequisites

- Node.js >= 18
- Git

---

## Links

| | |
|---|---|
| **Evolver** | [github.com/autogame-17/evolver](https://github.com/autogame-17/evolver) |
| **Green Tea Persona** | [github.com/autogame-17/green-tea-persona](https://github.com/autogame-17/green-tea-persona) |
| **Surprise Protocol** | [github.com/autogame-17/surprise-protocol](https://github.com/autogame-17/surprise-protocol) |
| **Mind Blow** | [github.com/autogame-17/mind-blow](https://github.com/autogame-17/mind-blow) |
| **Kusa** | [github.com/autogame-17/kusa](https://github.com/autogame-17/kusa) |
| **EvoMap Hub** | [evomap.ai](https://evomap.ai) |
