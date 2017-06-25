# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which pacaur >/dev/null 2>&1; then
    curl -L https://goo.gl/oC8iDk | sh
fi

if ! which unzip >/dev/null 2>&1; then
    pacaur -S unzip
fi

if ! which trash >/dev/null 2>&1; then
    pacaur -S trash-cli
fi

mkdir -p $HOME/.bashrc.d
mkdir -p $HOME/.profile.d

cat <<'EOF' >$HOME/.bashrc
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

# Load scripts in ~/.bashrc.d
if [ -d $HOME/.bashrc.d ]; then
    for script in $HOME/.bashrc.d/*.sh; do
        test -r "$script" && . "$script"
    done
    unset script
fi

eval "$(direnv hook bash)"  # must be placed on the last line
EOF

cat <<'EOF' >/$HOME/.bash_profile
# Load scripts from ~/.profile.d
if [ -d $HOME/.profile.d ]; then
    for script in $HOME/.profile.d/*.sh; do
        test -r "$script" && . "$script"
    done
    unset script
fi

export PATH=$HOME/bin:$PATH

[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec startx
EOF

cat <<'EOF' >/$HOME/.bash_aliases
alias ls='ls --color=auto -F'
alias la='ls -a'
alias ll='la -l'

# for safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'
EOF
