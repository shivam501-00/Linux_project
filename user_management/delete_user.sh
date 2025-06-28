#!/bin/bash

##File of username to delete

FILE="user_to_delete.txt"

if [[ ! -f "$FILE" ]]; then
	echo "file $FILE not found, Please create it with username to delete"
	exit 1
fi
## Quite my solution if using for loop
#for username in $(cat $FILE)for username in $(cat $FILE)
#do

 #       if id "$username" &>/dev/null; then
  #              echo "Do you really want to delete $username? [y/N]"
   #             read -r CONFIRM
    #            if [[ "$CONFIRM" =~ ^[Yy]$ ]];then
     #                   sudo userdel -r "$username"
      #                  echo "$(date): Deleted user $username" >>logs/user_delete.log
       #                 echo " User $username deleted"
        #        else
         #               echo "skipped deleting $username"
     	  #      fi
       # else
       # echo "User $username does not exits"
       # fi
#done<"$FILE"

# Open the file with a separate file descriptor (FD 3)
exec 3< "$FILE"

# now using while 
while IFS= read -r username <&3; do
	[[ -z "$username"  ]] && continue #skip empty line

	if id "$username" 2>/dev/null; then
		read -p  "Do you really want to delete '$username' ? [y/N]" CONFIRM
		
		if [[ "$CONFIRM" == [Yy] ]]; then
			 sudo userdel -r "$username"
           		 echo "$(date): Deleted user $username" >> logs/user_delete.log
        	   	 echo "✅ User '$username' deleted."
 	        else
         		 echo "⏭️ Skipped deleting '$username'."
       	        fi
        else
       		 echo "⚠️ User '$username' does not exist."
    fi
done 


# Close file descriptor
exec 3<&-
	

