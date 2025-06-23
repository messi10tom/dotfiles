
#!/bin/bash

icon=""
info=$(bluetoothctl info)

powered=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
connected=$(echo "$info" | grep "Connected: yes")

if [[ "$powered" != "yes" ]]; then
    echo "{\"text\": \"$icon Off\", \"tooltip\": \"Bluetooth is turned off\"}"
    exit 0
fi

if [[ -n "$connected" ]]; then
    name=$(echo "$info" | grep "Name:" | cut -d ' ' -f2-)
    battery_hex=$(echo "$info" | grep "Battery Percentage" | awk '{print $3}')
    
    if [[ -n "$battery_hex" ]]; then
        battery=$((16#${battery_hex//[()x]/}))
        echo "{\"text\": \"$icon $name ($battery%)\", \"tooltip\": \"Connected to: $name\nBattery: $battery%\"}"
    else
        echo "{\"text\": \"$icon $name\", \"tooltip\": \"Connected to: $name\nBattery: Unknown\"}"
    fi
else
    echo "{\"text\": \"$icon On\", \"tooltip\": \"Bluetooth is on but no devices connected\"}"
fi

