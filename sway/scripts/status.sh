#!/bin/bash

get_battery() {
    local cap status symbol=""
    cap=$(< /sys/class/power_supply/BAT0/capacity)
    status=$(< /sys/class/power_supply/BAT0/status)
    case "$status" in
        Charging)    symbol="+" ;;
        Discharging) symbol="-" ;;
    esac
    echo "BAT: ${cap}%${symbol}"
}

get_volume() {
    local vol
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print $2*100}')
    [ -n "$vol" ] && printf "VOL: %.0f\n" "$vol" || echo "VOL: N/A"
}

get_network() {
    WIFI_INFO="WLAN: Off"
    ETH_INFO=""
    IP_ADDR="IP: N/A"

    if command -v nmcli >/dev/null 2>&1; then
        CONNECTIONS=$(nmcli -t -f TYPE,STATE,DEVICE,CONNECTION dev)
        while IFS= read -r LINE; do
            TYPE=$(echo "$LINE" | cut -d: -f1)
            STATE=$(echo "$LINE" | cut -d: -f2)
            DEVICE=$(echo "$LINE" | cut -d: -f3)
            NAME=$(echo "$LINE" | cut -d: -f4)

            if [ "$TYPE" = "wifi" ]; then
                if [ "$STATE" = "connected" ]; then
                    SIGNAL=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep '^\*' | cut -d: -f2)
                    SPEED=$(iw dev "$DEVICE" link | grep -oP 'tx bitrate: \K[^\s]+')
                    [ -n "$SPEED" ] && SPEED="${SPEED}Mbps"
                    WIFI_INFO="WLAN: $NAME ($SIGNAL%)${SPEED:+ $SPEED}"

                    # Get IP address for Wi-Fi
                    IP=$(ip -4 addr show "$DEVICE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
                    [ -n "$IP" ] && IP_ADDR="IP: $IP"
                elif [ "$STATE" = "disconnected" ]; then
                    WIFI_INFO="WLAN: On"
                else
                    WIFI_INFO="WLAN: Off"
                fi
            elif [ "$TYPE" = "ethernet" ]; then
                ETH_STATUS=$(cat /sys/class/net/"$DEVICE"/operstate 2>/dev/null)
                ETH_SPEED=$(cat /sys/class/net/"$DEVICE"/speed 2>/dev/null)
                if [ "$ETH_STATUS" = "up" ]; then
                    ETH_INFO="ETH: Up${ETH_SPEED:+ ${ETH_SPEED}Mbps}"

                    # Get IP address for Ethernet
                    IP=$(ip -4 addr show "$DEVICE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
                    [ -n "$IP" ] && IP_ADDR="IP: $IP"
                else
                    ETH_INFO="ETH: Down"
                fi
            fi
        done <<< "$CONNECTIONS"
        [ -z "$ETH_INFO" ] && ETH_INFO="ETH: Down"
    else
        WIFI_INFO="WLAN: Unknown"
        ETH_INFO="ETH: Unknown"
    fi

    echo "$WIFI_INFO   $ETH_INFO   $IP_ADDR"
}

get_bluetooth() {
    local status="BT: Off" devices=""

    if command -v bluetoothctl >/dev/null 2>&1; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            status="BT: "
            mapfile -t macs < <(bluetoothctl devices | awk '{print $2}')
            for mac in "${macs[@]}"; do
                if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                    name=$(bluetoothctl info "$mac" | awk -F'Name: ' '/Name:/ {print $2; exit}')
                    devices+="${name},"
                fi
            done
            devices=${devices%,} # trim trailing comma
            [ -z "$devices" ] && devices="On"
        fi
    else
        status="BT: NULL"
    fi

    echo "$status$devices"
}

get_media() {
    if command -v playerctl >/dev/null 2>&1; then
        local status artist title
        status=$(playerctl status 2>/dev/null)
        if [ "$status" = "Playing" ]; then
            artist=$(playerctl metadata artist 2>/dev/null)
            artist=$(echo "$artist" | sed 's/ - .*//')
            title=$(playerctl metadata title 2>/dev/null)
            if echo "$title" | grep -qi "$artist"; then
                echo "♫ $title"
            else
                echo "♫ $artist - $title"
            fi
        else
            echo ""
        fi
    else
        echo ""
    fi
}


get_cpu() {
    local cpu
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{usage = 100 - $8} END {printf("CPU: %.1f%%", usage)}')
    echo "$cpu"
}

get_ram() {
    if [ -f /proc/meminfo ]; then
        total_kb=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
        available_kb=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
        used_kb=$((total_kb - available_kb))

        total_gb=$(awk "BEGIN {printf \"%.1f\", $total_kb / 1024 / 1024}")
        used_gb=$(awk "BEGIN {printf \"%.1f\", $used_kb / 1024 / 1024}")

        echo "RAM: ${used_gb}G/${total_gb}G"
    else
        echo "RAM: N/A"
    fi
}

while true; do
    echo "$(get_media)   $(get_bluetooth)   $(get_network)   $(get_cpu)   $(get_ram)   $(get_volume)   $(get_battery)   $(date +"%a, %b %e  %H:%M") "
    sleep 5
done
