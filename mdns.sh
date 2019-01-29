# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

source $(dirname $0)/common.sh

# Keep this script idempotent.

install avahi
install nss-mdns

HOSTS=$(cat <<EOF | tr '\n' ' '
files
mymachines
myhostname
mdns_minimal [NOTFOUND=return]
resolve [!UNAVAIL=return]
dns
EOF
)

sudo sed -i -e "s/^hosts:.*\$/hosts: $HOSTS/" /etc/nsswitch.conf
sudo systemctl start avahi-daemon
sudo systemctl enable avahi-daemon
