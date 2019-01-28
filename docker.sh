# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! pacaur -Qs polkit >/dev/null 2>&1; then
    pacaur -S polkit
fi

if ! which docker >/dev/null 2>&1; then
    pacaur -S docker
fi

if ! which docker-compose >/dev/null 2>&1; then
    pacaur -S docker-compose
fi

# https://wiki.archlinux.org/index.php/Docker#Installation
sudo tee /etc/modules-load.d/loop.conf <<<"loop"
sudo modprobe loop
systemctl enable docker
