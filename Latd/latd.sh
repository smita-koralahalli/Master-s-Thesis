#!/bin/bash

# ensure running as root
if [ "$(id -u)" != "0" ]; then
	exec sudo "$0" "$@"
fi

#Defaults changed after evaluating performance and the best fit
bash -c 'sudo sysctl -w vm.overcommit_memory=0'
bash -c 'sudo sysctl -w vm.swappiness=90'
bash -c 'sudo echo 3 > /proc/sys/vm/drop_caches'
bash -c 'sudo sysctl -w vm.dirty_background_ratio=2'
bash -c 'sudo sysctl -w vm.dirty_ratio=100'

#PSI statistics and memory availability statistics 
gnome-terminal --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/thesis; chmod +x memstat.sh; ./memstat.sh $SHELL'" --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/thesis; chmod +x psi.sh; ./psi.sh $SHELL'"

#pytorch application
gnome-terminal --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/PyTorch-YOLOv3; python3 detect1.py; $SHELL'" 
sleep 5

#Individual Memory stastics for pytorch application
gnome-terminal --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/thesis; chmod +x memory.sh; ./memory.sh $SHELL'"

#Microbenchmark memory hog--oomkill application
gnome-terminal --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/thesis; ./oomkill; $SHELL'"
PID="$(pidof oomkill)"

#Individual Memory stastics for oomkill application
gnome-terminal --tab --command="bash -c 'cd /home/edge_computing/Documents/THESIS_SMITA/thesis; chmod +x memory1.sh; ./memory1.sh $SHELL'"

#PSI metric as a control
some=`cat /proc/pressure/io| cut -d' ' -f5| sed -n 1p | cut -d= -f2` #Memory stall in us (accumulated some)
full=`cat /proc/pressure/io | cut -d' ' -f5| sed -n 2p | cut -d= -f2` #Memory stall in us (accumulated full)
some1=$(echo $some)


process_mem ()
{
	
	some=`cat /proc/pressure/memory| cut -d' ' -f5| sed -n 1p | cut -d= -f2` #Memory stall in us (accumulated some)
	full=`cat /proc/pressure/memory | cut -d' ' -f5| sed -n 2p | cut -d= -f2` #Memory stall in us (accumulated full)
	echo "${some1} ${some}"	
	if [ "${some1}" -lt "${some}" -a  ! "$(ps -o state= -p $PID)" = T ]; then  #If pressure changes, and its not already stopped (T=Stopped process); avoids recursive stop and deadlock
		kill -SIGSTOP $PID
	fi
	if [ "${some1}" -eq "${some}" -a  "$(ps -o state= -p $PID)" = T ]; then    #If pressure becomes constant restart the stopped process, work continued
		kill -SIGCONT $PID
	fi
	some1=$(echo $some)
	TotalSwap=`free -k | tr -s ' ' | cut -d' ' -f2 | sed -n 3p`			 #Total Swap
	UsedSwap=`free -k | tr -s ' ' | cut -d' ' -f3 | sed -n 3p`  			 #Used Swap
	Usedswapp=$( printf '%.02f' $(echo "$UsedSwap / $TotalSwap * 100" | bc -l) )	 #Used Swap %
	result1=${Usedswapp/.*}
	if [ "$result1" -gt 30 ]; then       #Assumption made as total memory = RAM + 30%Swap to study
		kill $PID
	fi
}


while :
do
	process_mem
	sleep 0.1
done


