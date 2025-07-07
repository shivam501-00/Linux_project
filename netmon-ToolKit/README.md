# 🧠 Network Management Shell Scripts

A collection of Bash scripts to help manage and troubleshoot networking on Linux systems.

## 📁 Included Scripts

### 1. `network_info.sh`
Displays network interface details, routing table, and DNS settings.

### 2. `ping_test.sh`
Ping any target and check basic connectivity.

### 3. `dns_lookup.sh`
Resolve domain names using `dig`.

### 4. `port_scan.sh`
Scan specific port ranges on any target (requires `nmap`).

### 5. `bandwidth_check.sh`
Basic speed test using `wget`.

### 6. `firewall_control.sh`
Start/stop firewall, open or block ports (requires `firewalld`).

## 🔧 Requirements
- `bash`, `dig`, `ip`, `wget`, `nmap`, `firewalld`
- `sudo` privileges for firewall operations

## 🔒 Usage
```bash
chmod +x *.sh
./network_info.sh
```

## 🧑‍💻 Author
**Shivam Khedekar**

