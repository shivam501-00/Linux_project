#!/bin/bash
read -rp "Enter IP/host: " host
read -rp "Enter port range (e.g., 20-80): " range
nmap -p "$range" "$host"

