# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

echo Installing keychain...
if ! which keychain >/dev/null 2>&1; then
    pacaur -S keychain
fi


# https://wiki.archlinux.org/index.php/SSH_keys#Keychain
echo Installing keychain.sh into the .bashrc.d folder...
mkdir -p $HOME/.bashrc.d
cat <<'EOF' >$HOME/.bashrc.d/keychain.sh
eval $(keychain --eval --quiet id_ed25519)
EOF

echo Done
