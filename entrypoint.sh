#!/bin/bash

# Zkopírovat skills do ~/.claude/skills pro Claude Code pokud ještě neexistují
if [ ! -d "$HOME/.claude/skills/prd" ]; then
    mkdir -p "$HOME/.claude/skills"
    cp -r "$HOME/.local/share/ralph/skills/prd" "$HOME/.claude/skills/"
fi

if [ ! -d "$HOME/.claude/skills/ralph" ]; then
    mkdir -p "$HOME/.claude/skills"
    cp -r "$HOME/.local/share/ralph/skills/ralph" "$HOME/.claude/skills/"
fi

exec "$@"
