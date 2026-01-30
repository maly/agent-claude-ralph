#!/bin/bash

# Install Ralph if not present (allows ~/.local/share/ralph to be a mounted volume)
RALPH_DIR="$HOME/.local/share/ralph"
if [ ! -f "$RALPH_DIR/ralph.sh" ]; then
    echo "Installing Ralph..."
    mkdir -p "$HOME/.local/share"
    git clone --depth=1 https://github.com/snarktank/ralph "$RALPH_DIR"
    chmod +x "$RALPH_DIR/ralph.sh"
fi

# Zkopírovat skills do ~/.claude/skills pro Claude Code pokud ještě neexistují
if [ ! -d "$HOME/.claude/skills/prd" ]; then
    mkdir -p "$HOME/.claude/skills"
    cp -r "$HOME/.local/share/ralph/skills/prd" "$HOME/.claude/skills/"
fi

if [ ! -d "$HOME/.claude/skills/ralph" ]; then
    mkdir -p "$HOME/.claude/skills"
    cp -r "$HOME/.local/share/ralph/skills/ralph" "$HOME/.claude/skills/"
fi

# Install dev-browser plugin if not present
if ! claude plugin list 2>/dev/null | grep -q "dev-browser"; then
    echo "Installing dev-browser plugin..."
    claude plugin marketplace add sawyerhood/dev-browser || true
    claude plugin install dev-browser@dev-browser-marketplace || true
fi

exec "$@"
