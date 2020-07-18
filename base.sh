# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

if ! which yay >/dev/null 2>&1; then
    echo 'Installing yay...'
    sh yay.sh
fi

install bash-completion
install cifs-utils
install direnv
install inetutils
install systemd-boot-pacman-hook
install trash-cli
install unzip

mkdir -p $HOME/.bashrc.d
mkdir -p $HOME/.profile.d

echo 'Installing .bashrc...'
cat <<'EOF' >$HOME/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_aliases

my_last_command_status_face() {
    local _status=$?

    # Use \001 and \002 instead of \[ and \].  The latter texts won't be
    # interpreted as espace sequences and they will be shown as normal texts.
    local _GREEN='\001\e[32m\002'
    local _RED='\001\e[31m\002'
    local _RESET='\001\e[0m\002'

    if [ $_status -eq 0 ]; then
        local _color=$_GREEN
        local _face='^_^)/'
    else
        local _color=$_RED
        local _face='>_<)\\'
    fi

    echo -en "${_color}${_face}${_RESET} "
}

# See https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto

PS1='\n\u@\h:\w$(__git_ps1)\n$(my_last_command_status_face)'

# Load scripts in ~/.bashrc.d
if [ -d $HOME/.bashrc.d ]; then
    for script in $HOME/.bashrc.d/*.sh; do
        test -r "$script" && . "$script"
    done
    unset script
fi

eval "$(direnv hook bash)"  # must be placed at the last line
EOF

echo 'Installing .bash_profile...'
cat <<'EOF' >$HOME/.bash_profile
# Load scripts from ~/.profile.d
if [ -d $HOME/.profile.d ]; then
    for script in $HOME/.profile.d/*.sh; do
        test -r "$script" && . "$script"
    done
    unset script
fi

export PATH=$HOME/bin:$PATH

if [ -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi

if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    exec startx
fi
EOF

echo 'Installing .bash_aliases...'
cat <<'EOF' >$HOME/.bash_aliases
alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='la -l'

# for safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'
EOF
