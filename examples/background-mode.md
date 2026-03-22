# Example: Back Room Work (No tmux)

## Scenario

You're SSHed into a server, no tmux. You: "Refactor the auth middleware to use JWT"

## What Happens

### Roll Call

```
Checking the roster...
Codex? Present. tmux? Not here.

No desks available. Sending agent to the back room.
I'll check on them periodically.
```

### The Assignment

Claude writes `/tmp/assignment-auth.txt`:

```
You have one job. Do it now. No questions. No brainstorming. No proposals. Just make these exact changes.

You are working on an Express.js API. Currently using session-based auth. We're moving to JWT.

## Assignment: Refactor auth middleware to JWT

### Situation
The old session-based auth is getting replaced. Your job: rip out session checks, wire in JWT.

### Deliverables:
1. **`src/middleware/auth.ts`** — Replace session check with JWT verification using `jsonwebtoken`. Token from `Authorization: Bearer <token>` header.
2. **`src/routes/login.ts`** — Generate JWT on successful login instead of creating session.
3. **`src/middleware/auth.test.ts`** — Updated tests for JWT flow.

### Quality Check
Run: `pnpm type-check && pnpm test -- --filter auth`
Everything passes. Non-negotiable.

### Boundaries
- Do NOT remove session middleware yet — other routes still depend on it.
- Do NOT change the User model. Not your department.
- JWT secret comes from `process.env.JWT_SECRET`. Don't hardcode anything.
```

### Deploy to the Back Room

```bash
TASK_ID=$(date +%s)
LOG="/tmp/worklog-$TASK_ID.txt"
REPORT="/tmp/report-$TASK_ID"

cat /tmp/assignment-auth.txt | codex exec --full-auto -C "/home/deploy/api" - > "$LOG" 2>&1 ; echo $? > "$REPORT" &
```

"Agent sent to the back room. Work log: `/tmp/worklog-$TASK_ID.txt`"

### Checking In

```
Peeking at the work log...

$ tail -10 /tmp/worklog-1711234567.txt
Reading src/middleware/auth.ts...
Replacing session validation with JWT verification...
Writing src/middleware/auth.ts...
Updating login route...

Still working. I'll check back.
```

### Agent Clocks Out

```
Report filed. Exit code: 0. Let me inspect.

$ git diff --stat
 src/middleware/auth.ts      | 34 +++++++++++--------
 src/routes/login.ts         | 12 ++++---
 src/middleware/auth.test.ts  | 48 ++++++++++++++++-----------
 3 files changed, 55 insertions(+), 39 deletions(-)

Running quality check... type-check passes. Tests pass.

Agent delivered from the back room. Clean work despite no supervision.
Signed off. Floor's clean.
```

### Cleanup

```bash
rm -f /tmp/assignment-auth.txt /tmp/report-$TASK_ID /tmp/worklog-$TASK_ID.txt
```

"Ready for your review."
