#!/bin/bash

LOGFILE="logs/usermodify.log"

log_entry() {
	echo "$(date) - $1 ">>$LOGFILE
}

read -p "Please enter username user you want to modify : " username

if id "$username" &>/dev/null; then 
	echo "User $username exist"
else
	echo "Please enter correct username"
	exit 1
fi

echo "Please select option from below"
echo "1. To change username"
echo "2. To change expiry date"
echo "3. To Lock account"
echo "4. To unlock account"
read -p "select any of above : " option

case $option in 
	1)
		read -p "enter new username : " newname 
		usermod -l "$newname" "$username"
		if [[ $? -eq 0 ]]; then
			echo "username $username changed to $newname"  
			log_entry "username $username changed to $newname"  
		else 
			echo "Failed to change username"  

		fi
		;;

	2)
		read -p "Enter new expiry date [YYYY-MM-DD]: " expiry
		chage -E "$expiry" "$username"
  		 if [ $? -eq 0 ]; then
          		 echo "Expiry date updated to $expiry."
           		 log_entry "Updated expiry for $username to $expiry"
       		 else
       		    	 echo "Failed to change expiry date."
       		 fi
       		 ;;
	 3)
		 usermod -L $username 
		 if [ $? -eq 0 ]; then
           		 echo "User $username has been locked."
           		 log_entry "Locked user: $username"
       		 else
           		 echo "Failed to lock user."
       		 fi
       		 ;;
	 4) 
		 usermod -U $username 
		 if [[ $? -eq 0 ]]; then
			 echo "User $username is unlocked"
			 log_entry "User $username is unlocked"
		 else
			 echo "Failed to Unlock user."
		 fi
		 ;;

	 *) 
		 echo "Please select correct option"
		 ;;

	 esac

