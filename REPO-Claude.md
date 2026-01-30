# Agent Claude Ralph

A Docker image combining [Claude Code CLI](https://claude.ai) with [Ralph](https://github.com/snarktank/ralph) - an autonomous agent system for iterative task execution.

## What's Included

- **Claude Code CLI** - Anthropic's AI coding assistant
- **Ralph** - Autonomous agent that breaks down PRDs into tasks and executes them iteratively
- **PRD & Ralph skills** - Built-in skills for creating Product Requirements Documents and converting them to Ralph format

## Quick Start

### Linux/macOS

```bash
#!/bin/bash

docker run --rm -it \
  -e ANTHROPIC_BASE_URL="https://openrouter.ai/api" \
  -e ANTHROPIC_API_KEY="" \
  -e ANTHROPIC_AUTH_TOKEN="your-openrouter-key" \
  -e ANTHROPIC_MODEL="OpenAI/gpt-5.2" \
  -v "$PWD:/workspace" \
  -v "$PWD/.claude-config:/home/agent/.claude" \
  -v "$PWD/.claude-cache:/home/agent/.cache" \
  -v "$PWD/.ralph:/home/agent/.local/share/ralph" \
  agent-claude-ralph:latest
```

### Windows (PowerShell)

```powershell
docker run --rm -it `
  -e ANTHROPIC_BASE_URL="https://openrouter.ai/api" `
  -e ANTHROPIC_API_KEY="" `
  -e ANTHROPIC_AUTH_TOKEN="your-openrouter-key" `
  -e ANTHROPIC_MODEL="OpenAI/gpt-5.2" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.claude-config:/home/agent/.claude" `
  -v "${PWD}/.claude-cache:/home/agent/.cache" `
  -v "${PWD}/.ralph:/home/agent/.local/share/ralph" `
  agent-claude-ralph:latest
```

## Configuration

The image is pre-configured to use **OpenRouter** as the API provider. You can customize the following environment variables in the run scripts:

| Variable | Description | Default |
|----------|-------------|---------|
| `ANTHROPIC_BASE_URL` | API endpoint | `https://openrouter.ai/api` |
| `ANTHROPIC_API_KEY` | API key (leave empty for OpenRouter) | `""` |
| `ANTHROPIC_AUTH_TOKEN` | OpenRouter API key | - |
| `ANTHROPIC_MODEL` | Model to use | `OpenAI/gpt-5.2` |

To use Anthropic directly, set `ANTHROPIC_BASE_URL` to `https://api.anthropic.com` and provide your API key in `ANTHROPIC_API_KEY`.

## Workflow

### 1. Initial Setup

After starting the container, run `claude` once to complete the initial setup wizard and verify the correct model is being used.

### 2. Create a PRD

Inside Claude CLI, create a Product Requirements Document:

```
Load the prd skill and create a PRD for [your feature description]
```

This saves the PRD to `tasks/prd-[feature-name].md`.

### 3. Convert PRD to Ralph Format

Still in Claude CLI, convert the PRD to Ralph's JSON format:

```
Load the ralph skill and convert tasks/prd-[feature-name].md to prd.json
```

This creates `prd.json` in your workspace.

### 4. Run Ralph

Exit Claude CLI and run Ralph to execute the tasks autonomously:

```bash
ralph [max_iterations]
```

Default is 10 iterations. Ralph will work through the tasks defined in `prd.json`, using Claude to implement each one.

## More Information

- [agent-claude-ralph on GitHub](https://github.com/maly/agent-claude-ralph) - Source code for this image

- [Ralph on GitHub](https://github.com/snarktank/ralph) - Full documentation for the Ralph autonomous agent system
