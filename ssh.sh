# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! which keychain >/dev/null 2>&1; then
    pacaur -S keychain
fi

mkdir -p $HOME/.bashrc.d

# https://wiki.archlinux.org/index.php/SSH_keys#Keychain
cat <<'EOF' >$HOME/.bashrc.d/keychain.sh
eval $(keychain --eval --quiet id_rsa)
EOF
