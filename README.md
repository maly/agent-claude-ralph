# Agent Claude/Amp Ralph

[![Docker Hub](https://img.shields.io/docker/v/adent/agent-claude-ralph?label=Docker%20Hub&logo=docker)](https://hub.docker.com/r/adent/agent-claude-ralph)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Docker images combining **Claude Code CLI** or **Amp CLI** with **Ralph** - an autonomous agent system that turns Product Requirements Documents into working code through iterative task execution.

## Available Variants

| Variant | Image | CLI Tool |
|---------|-------|----------|
| **Claude Code** | `adent/agent-claude-ralph` | [Claude Code CLI](https://claude.ai) via OpenRouter |
| **Amp** | `adent/agent-amp-ralph` | [Amp CLI](https://ampcode.com) (native multi-model) |

## Features

- 🤖 **Claude Code CLI** or **Amp CLI** - AI-powered coding assistants
- 📋 **Ralph** - Autonomous agent for breaking down and executing complex tasks
- 📝 **Built-in Skills** - PRD creation and Ralph format conversion
- 🌐 **Playwright + dev-browser** - Headless browser testing with the [dev-browser](https://github.com/SawyerHood/dev-browser) skill
- 🔧 **Pre-configured** - Ready to use out of the box

## Prerequisites

- **Docker** - [Install Docker](https://docs.docker.com/get-docker/)

## Quick Start

### Claude Code Variant (OpenRouter)

1. **Download the run script** for your platform:
   - Linux/macOS: [`wiggum.sh`](wiggum.sh)
   - Windows: [`wiggum.ps1`](wiggum.ps1)

2. **Edit the script** and set your API credentials:
   ```bash
   -e ANTHROPIC_AUTH_TOKEN="your-openrouter-key"
   ```

3. **Run the container** from your project directory:
   ```bash
   # Linux/macOS
   chmod +x wiggum.sh
   ./wiggum.sh

   # Windows PowerShell
   .\wiggum.ps1
   ```

### Amp Variant

1. **Download the run script** for your platform:
   - Linux/macOS: [`wiggum-amp.sh`](wiggum-amp.sh)
   - Windows: [`wiggum-amp.ps1`](wiggum-amp.ps1)

2. **Edit the script** and set your Amp API key:
   ```bash
   -e AMP_API_KEY="your-amp-api-key"
   ```
   
   Get your API key at [ampcode.com/install](https://ampcode.com/install)

3. **Run the container** from your project directory:
   ```bash
   # Linux/macOS
   chmod +x wiggum-amp.sh
   ./wiggum-amp.sh

   # Windows PowerShell
   .\wiggum-amp.ps1
   ```

## Configuration

### Claude Code Variant

The image uses OpenRouter by default. Customize these environment variables:

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_BASE_URL` | API endpoint (default: `https://openrouter.ai/api`) |
| `ANTHROPIC_API_KEY` | API key for direct Anthropic access |
| `ANTHROPIC_AUTH_TOKEN` | OpenRouter API key |
| `ANTHROPIC_MODEL` | Model to use (default: `OpenAI/gpt-5.2`) |

### Amp Variant

| Variable | Description |
|----------|-------------|
| `AMP_API_KEY` | Your Amp API key from [ampcode.com](https://ampcode.com) |

## Documentation

See [HOWTO.md](HOWTO.md) for detailed usage instructions, including:
- Step-by-step workflow guide
- Creating PRDs with Claude Code or Amp
- Running Ralph for autonomous task execution

## Building

```bash
# Claude Code variant
./build.sh        # or build.ps1 on Windows

# Amp variant
./build-amp.sh    # or build-amp.ps1 on Windows
```

## Related Projects

- [Ralph](https://github.com/snarktank/ralph) - The autonomous agent system powering iterative task execution

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
