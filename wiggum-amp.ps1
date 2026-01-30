docker run --rm -it `
  -e AMP_API_KEY="your-amp-api-key" `
  -v "${PWD}:/workspace" `
  -v "${PWD}/.amp-config:/home/agent/.config/amp" `
  -v "${PWD}/.amp-cache:/home/agent/.cache" `
  -v "${PWD}/.ralph:/home/agent/.local/share/ralph" `
  adent/agent-amp-ralph:latest
