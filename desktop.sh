# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which startx >/dev/null 2>&1; then
    pacaur -S xorg-server
fi

if ! which xinit >/dev/null 2>&1; then
    pacaur -S xorg-xinit
fi

if ! which xterm >/dev/null 2>&1; then
    pacaur -S xterm
fi

if ! which xsel >/dev/null 2>&1; then
    pacaur -S xsel
fi

if ! tail -n 1 $HOME/.bash_profile | grep -sq startx; then
    cat <<'EOF' >> $HOME/.bash_profile

[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec startx
EOF
fi
