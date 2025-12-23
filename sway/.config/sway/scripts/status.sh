#!/bin/bash

battery() {
    local cap status symbol=""
    read -r cap < /sys/class/power_supply/BAT0/capacity
    read -r status < /sys/class/power_supply/BAT0/status
    case "$status" in
        Charging)       symbol="+" ;;
        Discharging)    symbol="-" ;;
        'Not charging') symbol="=" ;;
    esac
    echo "${cap}%${symbol}"
}

volume() {
    local vol
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | awk '{print int($2*100)}')
    [ -n "$vol" ] && echo "$vol" || echo ""
}

wlan() {
    if ! nmcli radio wifi | grep -q enabled; then
        echo "off"
        return
    fi

    local line
    line=$(nmcli -t -f ACTIVE,SSID,SIGNAL,RATE device wifi list | grep '^yes:' )

    if [ -z "$line" ]; then
        echo "on"
        return
    fi

    IFS=":" read -r _ ssid signal rate <<< "$line"
    echo "$ssid(${signal}%) $rate"
}

ethernet() {
    local dev state speed
    dev=$(nmcli -t -f DEVICE,TYPE device | awk -F: '$2=="ethernet"{print $1; exit}')
    state=$(nmcli -t -f DEVICE,STATE device | awk -F: -v d="$dev" '$1==d{print $2}')

    if [ "$state" != "connected" ]; then
        echo "down"
        return
    fi

    speed=$(ethtool "$dev" 2>/dev/null | awk -F': ' '/Speed/ {print $2}')

    echo "up $speed"
}

network_interface() {
    local iface ip
    iface=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5}')
    ip=$(ip -4 addr show "$iface" 2>/dev/null | awk '/inet / {print $2}')

    if [ -z "$iface" ]; then
        echo ""
    else
        echo "$iface $ip"
    fi
}

bluetooth() {
    local status="off" devices=""

    if command -v bluetoothctl >/dev/null 2>&1; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            status="on"
            mapfile -t macs < <(bluetoothctl devices | awk '{print $2}')
            for mac in "${macs[@]}"; do
                if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                    name=$(bluetoothctl info "$mac" | awk -F'Name: ' '/Name:/ {print $2; exit}')
                    devices+="${name},"
                fi
            done
            devices=${devices%,}  # Trim trailing comma
            devices=${devices:+($devices)}  # Wrap in parentheses if non-empty
        fi
    else
        status="null"
    fi

    echo "$status$devices"
}

media() {
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

cpu() {
    local cpu
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{usage = 100 - $8} END {printf("%.1f%%", usage)}')
    echo "$cpu"
}

ram() {
    if [ -f /proc/meminfo ]; then
        local total_kb available_kb used_kb total_gb used_gb
        total_kb=$(awk '/MemTotal:/ {print $2}' /proc/meminfo)
        available_kb=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
        used_kb=$((total_kb - available_kb))
        total_gb=$(awk "BEGIN {printf \"%.1f\", $total_kb / 1024 / 1024}")
        used_gb=$(awk "BEGIN {printf \"%.1f\", $used_kb / 1024 / 1024}")
        echo "${used_gb}/${total_gb}g"
    else
        echo "null"
    fi
}

cpu_temp() {
    sensors 2>/dev/null |
    awk '/Core [0-9]+:/ {gsub("[+°C]","",$3); if ($3>max) max=$3}
         END {if (max) print max "°C"}'
}

while true; do
    echo "\
[bt $(bluetooth)] \
[wlan $(wlan) eth $(ethernet) $(network_interface)] \
[cpu $(cpu) $(cpu_temp)] \
[mem $(ram)] \
[vol $(volume)] \
[bat $(battery)] \
[$(date +"%A %B %e %H:%M" | tr '[:upper:]' '[:lower:]')]"
    sleep 5
done
