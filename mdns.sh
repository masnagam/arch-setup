# This file is distributed under the MIT license.
# See LICENSE file in the project root for details.

# Keep this script idempotent.

if ! pacaur -Qe avahi >/dev/null 2>&1; then
    pacaur -S avahi
fi

if ! pacaur -Qe nss-mdns >/dev/null 2>&1; then
    pacaur -S nss-mdns
fi

HOSTS=$(cat <<EOF | tr '\n' ' '
files
mymachines
mdns_minimal [NOTFOUND=return]
resolve [!UNAVAIL=return]
dns
myhostname
EOF
)

sudo sed -i -e "s/^hosts:.*\$/hosts: $HOSTS/" /etc/nsswitch.conf
sudo systemctl start avahi-daemon
sudo systemctl enable avahi-daemon
