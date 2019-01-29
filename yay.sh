# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which pacman -Qs git >/dev/null 2>&1; then
    echo "Installing git..."
    sudo pacman -S git
fi

TMP=$HOME/tmp/yay
git clone https://aur.archlinux.org/yay.git $TMP
trap "rm -rf $TMP" EXIT
(cd $TMP; makepkg -si)
