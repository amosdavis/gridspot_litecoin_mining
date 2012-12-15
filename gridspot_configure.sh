#!/bin/bash
touch running_instances.txt
while true; do
	all_instances=$(python get_gridspot.py)
	for new_instance in $all_instances;do
#		echo "$new_instance"
		grep $new_instance running_instances.txt 1> /dev/null
		if [ $? -eq 1 ]; then
			echo "$new_instance" >> running_instances.txt
#			echo "$new_instance"
			ipaddr=$(echo -n $new_instance | awk -F ":" '{print $1}')
               		port=$(echo -n $new_instance | awk -F ":" '{print $2}')
	      	        uniqueid=$(uuidgen)
		        #sed -e 's/:/\ -p\ /g')
      			timeout 1800 knife bootstrap $ipaddr -p $port -x gridspot_user -i ~/gridspot -N $uniqueid --sudo --run-list 'role[miner]' &

		fi
	done
	date
	sleep 180
done
