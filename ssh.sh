#!/bin/sh

mkdir -p $HOME/.profle.d

# See https://wiki.archlinux.org/index.php/SSH_keys#ssh-agent
cat <<'EOF' >$HOME/.profile.d/ssh-agent.sh
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > $HOME/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<$HOME/.ssh-agent-thing)"
fi
EOF
