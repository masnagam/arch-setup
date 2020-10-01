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

# Need to install mozc_emacs_helper from the srouce.
# See https://github.com/google/mozc/blob/2018-02-26/docs/build_mozc_in_docker.md
#
# Run the following commands before building mozc_emacs_helper:
#
#   git checkout -f 2018-02-26
#   git submodule update
#
# Use the 2018-02-26 tag so that the mozc_emacs_helper works with the
# mozc-server installed using pacman, which is based on 2.23.2815.102.
