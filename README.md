# claude-cracks-the-whip

**Claude Code is the boss. Other AI agents are the workforce. Whip goes crack.**

A Claude Code skill that turns Claude into a no-nonsense foreman — handing out assignments to AI coding agents (Codex, Gemini, Kimi, whoever shows up), watching them work, inspecting their deliverables, and sending sloppy work back.

## The Problem

You're using Claude Code. It's great at planning, reviewing, and understanding your codebase. But when you have 5 independent tasks, doing them one-by-one is slow.

Meanwhile, other AI agents are great at heads-down grunt work but terrible at planning.

**What if Claude Code could just... boss them around?**

```
Claude Code (the boss)
    |
    |-- "You. Build this component. Now." -----> Agent 1 (at their desk)
    |-- "You. Write these tests. No excuses." -> Agent 2 (at their desk)
    |-- "You. Add this endpoint. Stay in lane." -> Agent 3 (in the back room)
    |
    v
  Inspects all deliverables. Sends sloppy work back. Ships the rest.
```

## What It Sounds Like

```
> crack the whip on these 3 features

Rolling call... Codex is on the roster. tmux is available. Good.

Cracking the whip — deploying 3 agents.

Agent 1 is at their desk — working on UserAvatar component.
Agent 2 is at their desk — working on auth middleware.
Agent 3 is at their desk — working on API endpoints.

...

All agents have clocked out. Inspecting deliverables.

Agent 1: Clean work. Passes inspection.
Agent 2: Cut corners on error handling. Sending them back with corrections.
Agent 3: Clean work. Passes inspection.

Correction sent to Agent 2. Waiting for resubmission...

Agent 2 resubmitted. Passes inspection this time.

All work signed off. Ready for your review.
```

## Features

- **Roll call** — auto-detects which agents are available (CLI tools, MCP servers)
- **3 work modes**: at their desk (tmux), in the back room (background), phone it in (MCP)
- **Instant notifications** via `tmux wait-for` — agents tap the boss on the shoulder when done (polling fallback for non-tmux)
- **Work logs** via `tee` — Claude reads the agent's full output for smarter reviews, not just `git diff`
- **Inspection loop** — reads work logs, reviews diffs, runs quality checks, sends sloppy work back
- **Agent-agnostic** — any AI that takes orders can join the crew

## Install

### Option 1: Copy

```bash
cp -r skill/ ~/.claude/skills/claude-cracks-the-whip/
```

### Option 2: Symlink (for development)

```bash
ln -s "$(pwd)/skill" ~/.claude/skills/claude-cracks-the-whip
```

### Option 3: One-liner

```bash
git clone https://github.com/YOUR_USERNAME/claude-cracks-the-whip.git /tmp/cctw && \
cp -r /tmp/cctw/skill ~/.claude/skills/claude-cracks-the-whip && \
rm -rf /tmp/cctw
```

After install, restart Claude Code. Triggers on: "use codex", "dispatch to codex", "crack the whip", "dispatch agents".

## How It Works

### 1. Roll Call

Claude checks the roster:

```
Codex? Present.
tmux? Present.
In a tmux session? Affirmative.

Full crew available. Deploying via tmux panes.
```

### 2. Write Assignments

Claude writes no-nonsense specs. Every assignment starts with:

```
You have one job. Do it now. No questions. No brainstorming.
No proposals. Just make these exact changes.
```

Then gives clear deliverables, quality checks, and boundaries. Stay in your lane.

### 3. Deploy

Agents get sent to their desks (tmux panes) with full logging and completion signals:

```bash
# Agent works in a visible pane, output logged, signals when done
tmux split-window -h "cat /tmp/assignment-1.txt | codex exec --full-auto -C '$REPO' - 2>&1 | tee /tmp/worklog-1.txt ; echo \${PIPESTATUS[0]} > /tmp/report-1 ; tmux wait-for -S agent-1-done"
tmux split-window -v "cat /tmp/assignment-2.txt | codex exec --full-auto -C '$REPO' - 2>&1 | tee /tmp/worklog-2.txt ; echo \${PIPESTATUS[0]} > /tmp/report-2 ; tmux wait-for -S agent-2-done"
```

### 4. Wait & Inspect

Claude blocks on `tmux wait-for` — no polling loops. Agents tap the boss when done:

```bash
# Blocks until agent signals (instant, no polling)
tmux wait-for agent-1-done
tmux wait-for agent-2-done
```

Then inspects:

- Reads work logs (what did they actually do, any errors, their reasoning?)
- Reviews `git diff` (what changed?)
- Runs quality checks (type-check, lint, tests)
- Sends sloppy work back with correction assignments
- Signs off on clean work

## Work Modes

| Mode | Metaphor | When | Requires |
|------|----------|------|----------|
| **tmux panes** | At their desk | You want to watch them work | tmux + in session |
| **Background** | In the back room | No tmux, or headless | Just the agent CLI |
| **MCP** | Phone it in | Need back-and-forth | MCP server configured |

## Agent Roster

| Agent | CLI | MCP |
|-------|-----|-----|
| OpenAI Codex | `codex exec --full-auto` | `mcp__codex__codex` |

More agents joining the crew soon. PRs welcome — bring your own worker.

## Examples

See [`examples/`](examples/):

- [`single-task.md`](examples/single-task.md) — One agent, one assignment
- [`parallel-tasks.md`](examples/parallel-tasks.md) — Three agents deployed simultaneously
- [`background-mode.md`](examples/background-mode.md) — Agents in the back room

## FAQ

**Q: Why not just use Claude Code for everything?**
A: You could. But a good boss delegates. When you have 4 independent tasks, deploying 4 agents to work in parallel is 4x faster. Claude stays focused on strategy and quality.

**Q: What if I don't have tmux?**
A: Agents work in the back room (background processes). Claude checks on them via log files. Not as pretty, but gets the job done.

**Q: Can I use agents other than Codex?**
A: Yes. The skill is agent-agnostic. Any CLI tool that accepts a prompt via stdin can be added to the roster.

**Q: What if an agent hangs waiting for input?**
A: Every assignment starts with "You have one job. No questions. No brainstorming." Agents that try to chat instead of code get that beaten out of them by the preamble.

**Q: What if two agents edit the same file?**
A: Claude detects conflicts during inspection, resolves them, and re-runs verification. It's the boss's job to coordinate.

## Contributing

PRs welcome. Especially:
- New agent backends (Gemini CLI, Kimi, Cursor, etc.)
- Task dependency graphs (do B after A clocks out)
- Better tmux layouts for large crews

## License

MIT
