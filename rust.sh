# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install curl

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p $HOME/.bashrc.d
cat <<'EOF' >$HOME/.bashrc.d/99-rust.sh
source $HOME/.cargo/env
EOF
