# Example: Three Agents, Three Assignments

## Scenario

You: "Add CRUD endpoints for users, posts, and comments"

## What Happens

### Roll Call

```
Checking the roster...
Codex? Present. tmux? Present. In session? Yes.

Three independent jobs. Deploying three agents.
Cracking the whip.
```

### The Assignments

Claude writes 3 assignment files. Each starts with:

```
You have one job. Do it now. No questions. No brainstorming. No proposals. Just make these exact changes.
```

**Agent 1** (`/tmp/assignment-users.txt`):
```
...
## Assignment: Build User CRUD endpoints

### Situation
The API has no user management. That's your problem now.

### Deliverables:
1. **`src/routes/users.ts`** — GET /, GET /:id, POST /, PUT /:id, DELETE /:id
2. **`src/routes/users.test.ts`** — Integration tests for all endpoints
3. **`src/routes/index.ts`** — Register the users router

### Quality Check
Run: `pnpm type-check && pnpm test -- --filter users`
Everything passes or you do it again.

### Boundaries
- Follow the pattern in `src/routes/health.ts`. Don't get creative.
- Use Prisma client from `src/lib/prisma.ts`.
- Do NOT modify the Prisma schema.
```

**Agent 2** and **Agent 3** get similar assignments for posts and comments.

### Deploy the Crew

```bash
# Three desks, three agents, no excuses
tmux split-window -h "cat /tmp/assignment-users.txt | codex exec --full-auto -C '$REPO' - ; echo \$? > /tmp/report-users"
tmux split-window -v "cat /tmp/assignment-posts.txt | codex exec --full-auto -C '$REPO' - ; echo \$? > /tmp/report-posts"
tmux select-pane -t 0
tmux split-window -v "cat /tmp/assignment-comments.txt | codex exec --full-auto -C '$REPO' - ; echo \$? > /tmp/report-comments"
```

"Three agents at their desks. Users, posts, comments. You can watch them work."

### Monitoring

```
Agent 1 (users): still working...
Agent 3 (comments): clocked out. Exit code: 0.
Agent 2 (posts): clocked out. Exit code: 0.
Agent 1 (users): clocked out. Exit code: 0.

All agents have reported back. Inspecting deliverables.
```

### Inspection

```
$ git diff --stat
 src/routes/users.ts          | 78 +++++++++++++++++++++++++
 src/routes/users.test.ts     | 95 +++++++++++++++++++++++++++++++
 src/routes/posts.ts          | 82 ++++++++++++++++++++++++++
 src/routes/posts.test.ts     | 91 +++++++++++++++++++++++++++++
 src/routes/comments.ts       | 74 ++++++++++++++++++++++++
 src/routes/comments.test.ts  | 88 ++++++++++++++++++++++++++++
 src/routes/index.ts          | 6 ++
 7 files changed, 514 insertions(+)

Agent 1 (users): clean work. Signed off.
Agent 2 (posts): clean work. Signed off.
Agent 3 (comments): registered router but missed the import. Sending back.
```

### Correction

Claude writes `/tmp/correction-comments.txt`:

```
You have one job. Fix this. Now.

In `src/routes/index.ts`, you registered the comments router but forgot the import.

Add this line at the top:
import { commentsRouter } from './comments'

Run: pnpm type-check
It must pass.
```

```bash
tmux split-window -h "cat /tmp/correction-comments.txt | codex exec --full-auto -C '$REPO' - ; echo \$? > /tmp/report-comments-fix"
```

"Agent 3 sent back with corrections. They'll learn."

### Final Sign-off

```
Agent 3 resubmitted. Import added. Type-check passes.

All work signed off. Floor's clean.
Three endpoints, three test suites, zero problems. Ready for your review.
```
