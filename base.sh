#!/bin/sh

pacaur -S trash-cli

mkdir -p $HOME/.bashrc.d
mkdir -p $HOME/.profile.d

cat <<-'EOF' >$HOME/.bashrc
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.bash_aliases

exit_status_face() {
    if [ $? -eq 0 ]; then
        echo '^_^)/ '
    else
        echo '>_<)\ '
    fi
}

PS1='\n\u@\h:\w\n$(exit_status_face)'

eval "$(direnv hook bash)"  # must be placed on the last line
EOF

cat <<-'EOF' >/$HOME/.bash_profile
# Load profiles from ~/.profile.d
if [ -d $HOME/.profile.d ]; then
    for profile in $HOME/.profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

export PATH=$HOME/bin:$PATH

[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec startx
EOF

cat <<-'EOF' >/$HOME/.bash_aliases
alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='la -l'

# for safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'
EOF
