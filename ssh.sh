# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

echo 'Installing keychain...'
install keychain

# https://wiki.archlinux.org/index.php/SSH_keys#Keychain
echo 'Installing keychain.sh into the .bashrc.d folder...'
mkdir -p $HOME/.bashrc.d
cat <<'EOF' >$HOME/.bashrc.d/keychain.sh
eval $(keychain --eval --quiet id_ed25519)
EOF
