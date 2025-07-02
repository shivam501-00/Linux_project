#!/bin/bash

LOGFILE="./firewall.log"

log_entry() {
	echo "$(date '+%Y-%m-%d %H:%M:%S')+ $1">> "$LOGFILE"
}

# Detetct firewall tool if firewall or iptable getting used
detect_firewall_tool() {
	if command -v firewall-cmd &>/dev/null; then
		echo "firewalld"
	elif command -v iptables &>/dev/null;then 
		echo "iptables"
	else 
		echo "none" 
	fi

}


FIREWALL=$(detect_firewall_tool)

if [[ $FIREWALL == "none" ]]; then
	echo "Firewall tool not found."
	exit 1
fi

# Menu Loop
 while true; do 

	 echo "============================ Firewall Manager ($FIREWALL)============================="
	 echo "1. Check Firewall Status"
	 echo "2. Open a port"
	 echo "3. Close a port"
	 echo "4. Allow an IP and port"
	 echo "5. Block an IP and port"
	 echo "6. List firewall rules"
	 echo "7. Exit"
	 read -p "Please choose option[1-7]: " option

	 case $option in 
		 1)
			 if [[ $FIREWALL -eq "firewalld" ]]; then 
				 firewall-cmd --state 
			 else
				 systemctl status iptables
			 fi
			 ;;
		 2) 
			 read -p "Add prot number which you want to add: " port
			 if [[ $FIREWALL -eq "firewalld" ]]; then
				 firewall-cmd --add-port=${port}/tcp --permanent
				 firewall-cmd --reload
			 else
				 iptables -A INPUT -p tcp --dport "$port" -j Accept 
				 service iptables save
			 fi
			 log_entry "Prot $port is added to firewall"
			 ;;
		 3)
			 read -p "Enter port number you want to remove: " port
			 if [[ $FIREWALL -eq "firewalld" ]]; then
				 firewall-cmd --remove-port=${port}/tcp --permanent
				 firewall-cmd --reload
			 else
				 iptables -D INPUT -p tcp --deport "$prot" -j Accept
				 service iptables save
			 fi
			 log_entry "port $port is removed from firewall"
			 ;;

		4) 
			 read -p "Enter port to allow: " port
			 read -p "Enter IP to allow: " ip
			 if [[ $FIREWALL -eq "firewalld" ]]; then
				 # add rich rule 
				 firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='${ip}' port protocol='tcp' port='${port}' accept"
				 firewall-cmd --reload
      				 echo "✅ Allowed $ip on port $port using firewalld (rich rule)"
   			 else
      				 # Use iptables
        			 iptables -A INPUT -p tcp -s "$ip" --dport "$port" -j ACCEPT
        			 service iptables save
        			 echo "✅ Allowed $ip on port $port using iptables"
    			 fi
    			 log_entry "Allowed IP $ip on port $port"
   			 ;;

		5)
		         read -p "Enter IP to remove: " ip
 			 read -p "Enter port to remove for this IP: " port

 			 if [[ "$FIREWALL" == "firewalld" ]]; then
       				 # Remove the matching rich rule
       			 	firewall-cmd --permanent --remove-rich-rule="rule family='ipv4' source address='${ip}' port protocol='tcp' port='${port}' drop"
       			 	firewall-cmd --reload
       				echo "❌ Removed $ip access on port $port using firewalld"
   			 else
        			# Remove matching iptables rule (if exists)
       				iptables -D INPUT -p tcp -s "$ip" --dport "$port" -j DROP
        			service iptables save
        			echo "❌ Removed $ip access on port $port using iptables"
    			fi
    			log_entry "Removed IP $ip from port $port"
    			;;

		6)
			 echo "====== Active Firewall Rules ======"
           		 if [[ "$FIREWALL" == "firewalld" ]]; then
                		firewall-cmd --list-all
            		 else
                		iptables -L -n -v
            		 fi
            		 ;;
        	7)
            		 echo "Exiting... 👋"
            		 break
            		 ;;
        	*)
            		echo "Invalid option. Try again."
            		;;
    	esac
    echo ""
done
