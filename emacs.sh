# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which -q emacs; then
    pacaur -S emacs
fi

if [ ! -e $HOME/.emacs.d ]; then
    git clone git@bitbucket.org:masnagam/.emacs.d.git $HOME/.emacs.d
fi

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
