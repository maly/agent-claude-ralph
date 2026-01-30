# Agent Amp Ralph

A Docker image combining [Amp CLI](https://ampcode.com) with [Ralph](https://github.com/snarktank/ralph) - an autonomous agent system for iterative task execution.

## What's Included

- **Amp CLI** - Sourcegraph's multi-model AI coding assistant (Claude Opus 4.5, GPT-5.2, and more)
- **Ralph** - Autonomous agent that breaks down PRDs into tasks and executes them iteratively
- **PRD & Ralph skills** - Built-in skills for creating Product Requirements Documents and converting them to Ralph format
- **dev-browser skill** - Headless browser for web testing

## Quick Start

### Linux/macOS

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

### Windows (PowerShell)

```powershell
docker run --rm -it `
  -e AMP_API_KEY="your-amp-api-key" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.amp-config:/home/agent/.config/amp" `
  -v "${PWD}/.amp-cache:/home/agent/.cache" `
  -v "${PWD}/.ralph:/home/agent/.local/share/ralph" `
  adent/agent-amp-ralph:latest
```

Get your API key at [ampcode.com/install](https://ampcode.com/install).

## Configuration

| Variable | Description |
|----------|-------------|
| `AMP_API_KEY` | Your Amp API key from [ampcode.com](https://ampcode.com) |

Amp automatically selects the best model for each task. It supports two modes:
- **smart** - Uses state-of-the-art models (Claude Opus 4.5, GPT-5.2)
- **rush** - Faster and cheaper, for well-defined tasks (Claude Haiku 4.5)

## Workflow

### 1. Initial Setup

After starting the container, run `amp` once to complete the initial setup.

### 2. Create a PRD

Inside Amp CLI, create a Product Requirements Document:

```
Load the prd skill and create a PRD for [your feature description]
```

This saves the PRD to `tasks/prd-[feature-name].md`.

### 3. Convert PRD to Ralph Format

Still in Amp CLI, convert the PRD to Ralph's JSON format:

```
Load the ralph skill and convert tasks/prd-[feature-name].md to prd.json
```

This creates `prd.json` in your workspace.

### 4. Run Ralph

Exit Amp CLI and run Ralph to execute the tasks autonomously:

```bash
ralph [max_iterations]
```

Default is 10 iterations. Ralph will work through the tasks defined in `prd.json`.

## Managing Skills

```bash
# List installed skills
amp skill list

# Add a skill from GitHub
amp skill add owner/repo/skill-name

# Add with custom name
amp skill add owner/repo/skill-name --name my-skill
```

## More Information

- [agent-claude-ralph on GitHub](https://github.com/maly/agent-claude-ralph) - Source code for this image
- [Amp Manual](https://ampcode.com/manual) - Amp CLI documentation
- [Ralph on GitHub](https://github.com/snarktank/ralph) - Full documentation for the Ralph autonomous agent system
