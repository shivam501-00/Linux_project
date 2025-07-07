#!/bin/bash
echo "1. Enable firewall"
echo "2. Disable firewall"
echo "3. Open port"
echo "4. Block port"
read -rp "Choose option: " opt

case $opt in
    1) sudo systemctl start firewalld ;;
    2) sudo systemctl stop firewalld ;;
    3) read -rp "Port to open: " port
       sudo firewall-cmd --permanent --add-port=${port}/tcp
       sudo firewall-cmd --reload ;;
    4) read -rp "Port to block: " port
       sudo firewall-cmd --permanent --remove-port=${port}/tcp
       sudo firewall-cmd --reload ;;
    *) echo "Invalid option" ;;
esac

