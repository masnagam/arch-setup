#!/bin/sh

pacaur -S emacs

git clone git@bitbucket.org:masnagam/.emacs.d.git $HOME/.emacs.d

mkdir -p $HOME/bin

cat <<-'EOF' >$HOME/bin/em
#!/bin/sh
emacsclient --alternate-editor='' -n $@
EOF

cat <<-'EOF' >$HOME/bin/kem
#!/bin/sh
emacsclient -e '(kill-emacs)'
EOF

chmod +x $HOME/bin/em
chmod +x $HOME/bin/kem
