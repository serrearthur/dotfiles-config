#!/usr/bin/env bash
envfile=/home/keupon/.ssh/environment
[ -e "$envfile" ] && . "$envfile" >/dev/null

# Check if the daemon is already running. If not, we launch ssh-agent in the background
[ "$SSH_AUTH_SOCK" ] && [ "$SSH_AGENT_PID" ] && [ -e "$SSH_AUTH_SOCK" ] && ! ps -p "$SSH_AGENT_PID" &>/dev/null && ssh-agent > "$envfile"
