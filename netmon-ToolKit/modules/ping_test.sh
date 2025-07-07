#!/bin/bash
read -rp "Enter host/IP to ping: " target
ping -c 4 "$target"

