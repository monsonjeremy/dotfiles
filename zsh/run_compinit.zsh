#!/usr/bin/env zsh

autoload -Uz compinit

zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -f "$zcompdump" ]] && find "$zcompdump" -mtime -1 -print -quit 2>/dev/null | grep -q .; then
  # Trust recently generated completion dump for faster shell startup.
  compinit -C -d "$zcompdump"
else
  compinit -d "$zcompdump"
fi
