#!/bin/bash
read -rp "Enter domain name: " domain
dig "$domain" +short

