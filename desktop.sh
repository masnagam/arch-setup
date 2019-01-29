# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

# X

install xorg-server
install xorg-xinit
install xsel

# i3

install i3-wm
install dex
install i3blocks
install rofi

# Terminal Emulator

install alacritty

# Fonts

install noto-fonts-cjk
install noto-fonts-emoji
install ttf-font-awesome
install ttf-myrica

# Input Method

install fcitx-mozc
install fcitx-configtool
install fcitx-im

# Web Browsers

install google-chrome
install firefox

# Communication Tools

install skypeforlinux-stable-bin

# Configurations

cat <<'EOF' >$HOME/.xinitrc
#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export TERMINAL=alacritty

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

exec i3
EOF

if ! tail -n 1 $HOME/.bash_profile | grep -sq startx; then
    cat <<'EOF' >> $HOME/.bash_profile

[[ -z $DISPLAY && $(tty) == /dev/tty1 ]] && exec startx
EOF
fi

git_clone git@github.com:masnagam/i3-config.git $HOME/.config/i3
