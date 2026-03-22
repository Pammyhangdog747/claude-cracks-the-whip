# Contributing

Thanks for helping improve `claude-cracks-the-whip`. This project accepts focused contributions, especially new agent backends. Keep changes narrow, document them clearly, and make sure the skill works locally before you open a pull request.

## Fork and Clone

1. Fork the repository on GitHub.
2. Clone your fork locally:

```bash
git clone https://github.com/YOUR_USERNAME/claude-cracks-the-whip.git
cd claude-cracks-the-whip
```

3. Create a branch for your work:

```bash
git checkout -b add-my-agent-backend
```

## Adding a New Agent Backend

If you are adding support for a new agent backend, update the agent roster in both of these files:

- `skill/SKILL.md`
- `README.md`

Add a new row to each "Agent Roster" table so contributors and users can see:

- The agent name
- The CLI command used to run it
- The MCP entry point, if one exists

Keep the naming and command examples consistent across both files. One backend per pull request.

## Test Locally

Install the local skill copy into Claude Code:

```bash
mkdir -p ~/.claude/skills/claude-cracks-the-whip
cp -r skill/* ~/.claude/skills/claude-cracks-the-whip/
```

Then restart Claude Code so it reloads the skill. Test the backend entry you added and confirm the roster information is correct.

## Pull Request Guidelines

- Keep the PR focused.
- Add only one agent backend per PR.
- Describe the backend you added and how you tested it locally.
- Do not bundle unrelated cleanup or refactors.

## Code of Conduct

Be nice. Be respectful, constructive, and easy to work with.
