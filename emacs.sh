# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install emacs
install cask
install ripgrep

git_clone git@github.com:masnagam/.emacs.d.git $HOME/.emacs.d

mkdir -p $HOME/bin

cat <<'EOF' >$HOME/bin/em
#!/bin/sh
emacsclient --alternate-editor='' -n $@
EOF

cat <<'EOF' >$HOME/bin/kem
#!/bin/sh
emacsclient -e '(kill-emacs)'
EOF

chmod +x $HOME/bin/em
chmod +x $HOME/bin/kem
