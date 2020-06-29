# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

# X

install xorg-server
install xorg-xdpyinfo
install xorg-xinit
install xorg-xprop
install xorg-xev
install xsel

# i3

install i3-wm
install dex
install i3blocks
install rofi

# Terminal Emulator

install sakura

# Fonts

install noto-fonts-cjk
install noto-fonts-emoji
install ttf-font-awesome
install ttf-myrica

sudo ln -sf /etc/fonts/conf.avail/66-noto-mono.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/66-noto-sans.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/66-noto-serif.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/70-noto-cjk.conf /etc/fonts/conf.d/

# Input Method

install fcitx-mozc
install fcitx-configtool
install fcitx-im

# Sound

install alsa-utils
install pulseaudio
install pulseaudio-alsa

# compositor

install glxinfo
install xcompmgr

# Web Browsers

install google-chrome
install firefox

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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# default terminal application
export TERMINAL=sakura

# IME settings
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# generate config for i3
$HOME/.config/i3/mkconfig

xcompmgr -c -n &

exec i3
EOF

git_clone git@github.com:masnagam/i3-config.git $HOME/.config/i3
