# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install polkit
install docker
install docker-compose

# https://wiki.archlinux.org/index.php/Docker#Installation
sudo tee /etc/modules-load.d/loop.conf <<< "loop"
sudo modprobe loop
systemctl enable docker
sudo groupmems -g docker -a $(whoami)
