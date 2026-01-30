docker run --rm -it `
  -e ANTHROPIC_BASE_URL="https://openrouter.ai/api" `
  -e ANTHROPIC_API_KEY="" `
  -e ANTHROPIC_AUTH_TOKEN="your-openrouter-key" `
  -e ANTHROPIC_MODEL="OpenAI/gpt-5.2" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.claude-config:/home/agent/.claude" `
  -v "${PWD}/.claude-cache:/home/agent/.cache" `
  -v "${PWD}/.ralph:/home/agent/.local/share/ralph" `
  adent/agent-claude-ralph:latest
x