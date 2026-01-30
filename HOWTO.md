# Agent Claude/Amp Ralph

Docker images combining [Claude Code CLI](https://claude.ai) or [Amp CLI](https://ampcode.com) with [Ralph](https://github.com/snarktank/ralph) - an autonomous agent system for iterative task execution.

## Available Variants

| Variant | Image | CLI Command |
|---------|-------|-------------|
| **Claude Code** | `adent/agent-claude-ralph` | `claude` |
| **Amp** | `adent/agent-amp-ralph` | `amp` |

## What's Included

- **Claude Code CLI** or **Amp CLI** - AI coding assistants
- **Ralph** - Autonomous agent that breaks down PRDs into tasks and executes them iteratively
- **PRD & Ralph skills** - Built-in skills for creating Product Requirements Documents and converting them to Ralph format
- **dev-browser skill** - Headless browser for web testing

## Quick Start

### Claude Code Variant

#### Linux/macOS

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
  adent/agent-claude-ralph:latest
```

#### Windows (PowerShell)

```powershell
docker run --rm -it `
  -e ANTHROPIC_BASE_URL="https://openrouter.ai/api" `
  -e ANTHROPIC_API_KEY="" `
  -e ANTHROPIC_AUTH_TOKEN="your-openrouter-key" `
  -e ANTHROPIC_MODEL="OpenAI/gpt-5.2" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.claude-config:/home/agent/.claude" `
  -v "${PWD}/.claude-cache:/home/agent/.cache" `
  adent/agent-claude-ralph:latest
```

### Amp Variant

#### Linux/macOS

```bash
#!/bin/bash

docker run --rm -it \
  -e AMP_API_KEY="your-amp-api-key" \
  -v "$PWD:/workspace" \
  -v "$PWD/.amp-config:/home/agent/.config/amp" \
  -v "$PWD/.amp-cache:/home/agent/.cache" \
  -v "$PWD/.ralph:/home/agent/.local/share/ralph" \
  adent/agent-amp-ralph:latest
```

#### Windows (PowerShell)

```powershell
docker run --rm -it `
  -e AMP_API_KEY="your-amp-api-key" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.amp-config:/home/agent/.config/amp" `
  -v "${PWD}/.amp-cache:/home/agent/.cache" `
  -v "${PWD}/.ralph:/home/agent/.local/share/ralph" `
  adent/agent-amp-ralph:latest
```

Get your Amp API key at [ampcode.com/install](https://ampcode.com/install).

## Configuration

### Claude Code Variant

The image is pre-configured to use **OpenRouter** as the API provider:

| Variable | Description | Default |
|----------|-------------|---------|
| `ANTHROPIC_BASE_URL` | API endpoint | `https://openrouter.ai/api` |
| `ANTHROPIC_API_KEY` | API key (leave empty for OpenRouter) | `""` |
| `ANTHROPIC_AUTH_TOKEN` | OpenRouter API key | - |
| `ANTHROPIC_MODEL` | Model to use | `OpenAI/gpt-5.2` |

To use Anthropic directly, set `ANTHROPIC_BASE_URL` to `https://api.anthropic.com` and provide your API key in `ANTHROPIC_API_KEY`.

### Amp Variant

Amp uses its own API with native multi-model support:

| Variable | Description |
|----------|-------------|
| `AMP_API_KEY` | Your Amp API key from [ampcode.com](https://ampcode.com) |

Amp automatically selects the best model for each task (Claude Opus 4.5, GPT-5.2, etc.).

## Workflow

### 1. Initial Setup

After starting the container, run the CLI once to complete the initial setup:

```bash
# Claude Code variant
claude

# Amp variant
amp
```

### 2. Create a PRD

Inside the CLI, create a Product Requirements Document:

```
Load the prd skill and create a PRD for [your feature description]
```

This saves the PRD to `tasks/prd-[feature-name].md`.

### 3. Convert PRD to Ralph Format

Still in the CLI, convert the PRD to Ralph's JSON format:

```
Load the ralph skill and convert tasks/prd-[feature-name].md to prd.json
```

This creates `prd.json` in your workspace.

### 4. Run Ralph

Exit the CLI and run Ralph to execute the tasks autonomously:

```bash
ralph [max_iterations]
```

Default is 10 iterations. Ralph will work through the tasks defined in `prd.json`.

## Managing Skills

### Amp

```bash
# List installed skills
amp skill list

# Add a skill from GitHub
amp skill add owner/repo/skill-name

# Add with custom name
amp skill add owner/repo/skill-name --name my-skill
```

### Claude Code

```bash
# List installed plugins
claude plugin list

# Add a plugin
claude plugin marketplace add owner/plugin-name
```

## More Information

- [Ralph on GitHub](https://github.com/snarktank/ralph) - Full documentation for the Ralph autonomous agent system
- [Amp Manual](https://ampcode.com/manual) - Amp CLI documentation
- [Claude Code](https://claude.ai) - Claude Code CLI
