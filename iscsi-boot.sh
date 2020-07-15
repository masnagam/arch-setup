# This script is idempotent only when the same arguments are specified.

PORTAL="$1"
TARGET="$2"
INITIATOR="$3"

echo 'Installing open-iscsi...'
pacman -Sy open-iscsi

echo 'Installing /usr/lib/initcpio/install/iscsi...'
cat <<'EOF' >/usr/lib/initcpio/install/iscsi
build() {
    local mod
    for mod in iscsi_ibft iscsi_tcp libiscsi libiscsi_tcp scsi_transport_iscsi crc32c; do
        add_module "$mod"
    done

    add_checked_modules '/drivers/net'
    add_binary '/usr/bin/iscsistart'
    add_runscript
}

help() {
    cat <<HELPEOF
This hook allows you to boot from an iSCSI target.
HELPEOF
}
EOF

echo 'Installing /usr/lib/initcpio/hook/iscsi...'
cat <<EOF
run_hook() {
    modprobe iscsi_tcp
    iscsistart -a $PORTAL -t $TARGET -g 1 -i $INITIATOR
}
EOF

echo 'Updating /etc/mkinitcpio.conf...'
sed -i 's/^HOOKS=/HOOKS=(base udev autodetect modconf net iscsi block filesystems keyboard fsck)/' /etc/mkinitcpio.conf

echo 'Updating /boot/initramfs-linux*.img...'
mkinitcpio -p linux
