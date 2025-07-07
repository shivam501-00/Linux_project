#!/bin/bash

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

log() {
    echo "[$(date)] $1" >> "$LOG_DIR/netmon.log"
}

show_menu() {
    echo "=== NetMon Network Management Tool ==="
    echo "1. Show Network Info"
    echo "2. Ping Test"
    echo "3. DNS Lookup"
    echo "4. Port Scan"
    echo "5. Bandwidth Check"
    echo "6. Firewall Control"
    echo "7. Exit"
}

read_choice() {
    read -rp "Enter your choice: " choice
    case $choice in
        1) ./modules/network_info.sh ;;
        2) ./modules/ping_test.sh ;;
        3) ./modules/dns_lookup.sh ;;
        4) ./modules/port_scan.sh ;;
        5) ./modules/bandwidth_check.sh ;;
        6) ./modules/firewall_control.sh ;;
        7) exit 0 ;;
        *) echo "Invalid option";;
    esac
}

while true; do
    show_menu
    read_choice
    echo ""
done

