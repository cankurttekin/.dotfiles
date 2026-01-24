buds() {
  bluetooth on
  sleep 2
  bluetoothctl connect "$BT_BUDS_MAC"
  sleep 2
  pactl set-default-sink "$BT_BUDS_SINK"
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
