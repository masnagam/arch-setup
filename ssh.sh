# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install keychain

# https://wiki.archlinux.org/index.php/SSH_keys#Keychain
mkdir -p $HOME/.profile.d
cat <<'EOF' >$HOME/.profile.d/00-keychain.sh
eval $(keychain --eval --quiet id_ed25519)
EOF
