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

install i3-gaps
install dex
install i3blocks
install rofi

# Terminal Emulator

install rxvt-unicode

# Fonts

install noto-fonts
install noto-fonts-cjk
install noto-fonts-emoji
install noto-fonts-extra
install ttf-font-awesome
install ttf-myrica

# Input Method

install fcitx-mozc
install fcitx-configtool
install fcitx-im

# Sound

install alsa-utils
install pulseaudio
install pulseaudio-alsa

# Web Browsers

install google-chrome
install firefox

mkdir -p $HOME/.Xresources.d

echo 'Creating .xinitrc...'
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
export TERMINAL=urxvt

# IME settings
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# generate config for i3
$HOME/.config/i3/mkconfig

exec i3
EOF

echo 'Installing .config/i3 from masnagam/i3-config...'
git_clone git@github.com:masnagam/i3-config.git $HOME/.config/i3

echo "Creating .Xresources.d/color-theme..."
curl -fsSL https://raw.githubusercontent.com/solarized/xresources/master/Xresources.dark >$HOME/.Xresources.d/color-theme

echo 'Creating .Xresources.d/urxvt...'
cat <<EOF >$HOME/.Xresources.d/urxvt
URxvt.depth: 32
URxvt.fading: 40
URxvt.pointerBlank: true
URxvt.saveLines: 5000
URxvt.scrollBar_floating: true
URxvt.scrollBar_right: true
URxvt.scrollTtyKeypress: true
URxvt.scrollTtyOutput: false
URxvt.scrollWithBuffer: true
URxvt.scrollstyle: plain
URxvt.visualBell: true
EOF

cat <<EOF
Done.

Add the following lines in .Xresources:
#include ".Xresources.d/color-theme"
#include ".Xresources.d/urxvt"
EOF
