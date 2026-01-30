#!/bin/bash

# Install Ralph if not present (allows ~/.local/share/ralph to be a mounted volume)
RALPH_DIR="$HOME/.local/share/ralph"
if [ ! -f "$RALPH_DIR/ralph.sh" ]; then
    echo "Installing Ralph..."
    mkdir -p "$HOME/.local/share"
    git clone --depth=1 https://github.com/snarktank/ralph "$RALPH_DIR"
    chmod +x "$RALPH_DIR/ralph.sh"
fi

# Copy skills to ~/.config/amp/skills for Amp if they don't exist yet
SKILLS_DIR="$HOME/.config/amp/skills"
if [ ! -d "$SKILLS_DIR/prd" ]; then
    mkdir -p "$SKILLS_DIR"
    cp -r "$HOME/.local/share/ralph/skills/prd" "$SKILLS_DIR/"
fi

if [ ! -d "$SKILLS_DIR/ralph" ]; then
    mkdir -p "$SKILLS_DIR"
    cp -r "$HOME/.local/share/ralph/skills/ralph" "$SKILLS_DIR/"
fi

# Install dev-browser skill if not present
# Amp uses 'amp skill add' command for skills
if [ ! -d "$SKILLS_DIR/dev-browser" ]; then
    echo "Installing dev-browser skill..."
    amp skill add sawyerhood/dev-browser --name dev-browser 2>/dev/null || true
fi

exec "$@"
