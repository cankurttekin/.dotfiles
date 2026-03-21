buds() {
  bluetoothctl info "$BT_BUDS_MAC" | grep -q "Connected: yes" \
    && bluetoothctl disconnect "$BT_BUDS_MAC" \
    || bluetoothctl connect "$BT_BUDS_MAC"
}

wakehomelab() {
  wol "$HOMELAB_MAC"
}

killhomelab() {
  ssh -t "$HOMELAB_USER@$HOMELAB_HOST" "sudo shutdown -h now"
}

tfan() {
    local level="${1:-auto}"
    echo "level $level" | sudo tee /proc/acpi/ibm/fan >/dev/null
}
