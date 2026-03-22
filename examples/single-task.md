# Example: One Agent, One Assignment

## Scenario

You: "Add a UserAvatar component"

## What Happens

### Roll Call

```
Checking the roster...
Codex? Present. tmux? Present. In session? Yes.

One agent available. Deploying to their desk.
```

### The Assignment

Claude writes `/tmp/assignment-avatar.txt`:

```
You have one job. Do it now. No questions. No brainstorming. No proposals. Just make these exact changes.

You are working on a Next.js app with TypeScript and Tailwind CSS.

## Assignment: Build a UserAvatar component

### Situation
The app shows plain text usernames. Management wants avatars. That's your job.

### Deliverables:
1. **`src/components/UserAvatar.tsx`** — Component with props: `name: string`, `imageUrl?: string`, `size?: 'sm' | 'md' | 'lg'`. Tailwind styling. Initials from name. Deterministic color from name hash.
2. **`src/components/UserAvatar.test.tsx`** — Tests: renders initials, renders image when provided, size variants, color is deterministic.

### Quality Check
When you're done, run: `pnpm type-check && pnpm test -- --filter UserAvatar`
Everything must pass. No excuses.

### Boundaries
- Do NOT modify existing components. Stay in your lane.
- Do NOT install new dependencies. Work with what we have.
- Do NOT use external avatar services.
```

### Deploy

```bash
TASK_ID=$(date +%s)
tmux split-window -h "cat /tmp/assignment-avatar.txt | codex exec --full-auto -C '/Users/me/project' - ; echo \$? > /tmp/report-$TASK_ID"
```

"Agent deployed to their desk. Working on UserAvatar."

### Inspection

```
Agent clocked out. Exit code: 0. Let me inspect.

$ git diff --stat
 src/components/UserAvatar.tsx      | 45 ++++++++++++++++++++++++
 src/components/UserAvatar.test.tsx  | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

Running quality check... type-check passes. Tests pass.

Agent delivered clean work. Signed off.
```

### Cleanup

```bash
rm -f /tmp/assignment-avatar.txt /tmp/report-$TASK_ID
```

"Floor's clean. Ready for your review."
