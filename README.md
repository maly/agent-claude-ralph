# Agent Claude Ralph

[![Docker Hub](https://img.shields.io/docker/v/adent/agent-claude-ralph?label=Docker%20Hub&logo=docker)](https://hub.docker.com/r/adent/agent-claude-ralph)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Docker image combining **Claude Code CLI** with **Ralph** - an autonomous agent system that turns Product Requirements Documents into working code through iterative task execution.

## Features

- 🤖 **Claude Code CLI** - Anthropic's AI-powered coding assistant
- 📋 **Ralph** - Autonomous agent for breaking down and executing complex tasks
- 📝 **Built-in Skills** - PRD creation and Ralph format conversion
- 🌐 **Playwright + dev-browser** - Headless browser testing with the [dev-browser](https://github.com/SawyerHood/dev-browser) skill
- 🔧 **Pre-configured** - Ready to use with OpenRouter (customizable)

## Prerequisites

- **Docker** - [Install Docker](https://docs.docker.com/get-docker/)

## Quick Start

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

## Configuration

The image uses OpenRouter by default. Customize these environment variables in the run script:

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_BASE_URL` | API endpoint (default: `https://openrouter.ai/api`) |
| `ANTHROPIC_API_KEY` | API key for direct Anthropic access |
| `ANTHROPIC_AUTH_TOKEN` | OpenRouter API key |
| `ANTHROPIC_MODEL` | Model to use (default: `OpenAI/gpt-5.2`) |

## Documentation

See [HOWTO.md](HOWTO.md) for detailed usage instructions, including:
- Step-by-step workflow guide
- Creating PRDs with Claude
- Running Ralph for autonomous task execution

## Related Projects

- [Ralph](https://github.com/snarktank/ralph) - The autonomous agent system powering iterative task execution

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
