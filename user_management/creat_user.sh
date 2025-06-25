#!/bin/bash

input="users.csv"
logfile="logs/user_creation.log"

while IFS="," read -r username group
do 
	if id "$username" &>/dev/null;then
		echo "user $username already exist"| tee -a $logfile

	else
		useradd -m -G "$group" "$username" #-G just to add group beside default group that will be username it self and -m for creating home dir
		password=$(openssl rand -base64 8)
		echo "$username:$password"| chpasswd #so once password created we need to save it for that purpose
		chage -d 0 "$username" # change password on first login        if id=$username &>/dev/null;then
                echo "user $username already exist"| tee -a $logfile
		echo "Created user: $username | Group: $group | Temp Password: $password" | tee -a "$logfile"
    fi
done < "$input"
