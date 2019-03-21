#!/bin/bash 

PID="$(pidof python3 | cut -d' ' -f1)"
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memory.txt
echo Individual Memory Statistics | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memory.txt
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memory.txt
x=0
process_mem ()
{

#we need to check if 2 files exist
if [[ -f /proc/$PID/status ]];
then
	if [[ -f /proc/$PID/smaps ]]; 
	then
		#here we count memory usage, Pss, Private and Shared = Pss-Private
		time1=`date +"%T.%6N"`							                #Time in hours, minutes, seconds and milliseconds
		Pss=`cat /proc/$PID/smaps | grep -e "^Pss:" | awk '{print $2}'| paste -sd+ | bc `	#PSS MEMORY = Private(Clean+Dirty) + Shared(Clean+Dirty)/Number of Processes
		Rss=`cat /proc/$PID/smaps | grep -e "^Rss:" | awk '{print $2}'| paste -sd+ | bc `	#RSS MEMORY = Private(Clean+Dirty) + Shared(Clean+Dirty)
		Private=`cat /proc/$PID/smaps | grep -e "^Private" | awk '{print $2}'| paste -sd+ | bc ` #Private(Clean+Dirty)
		Shared1=`cat /proc/$PID/smaps | grep -e "^Shared" | awk '{print $2}'| paste -sd+ | bc `  #Shared(Clean+Dirty)
		Swap=`cat /proc/$PID/smaps | grep -e "^Swap" | awk '{print $2}'| paste -sd+ | bc `       #SwapUsed
		SwapPss=`cat /proc/$PID/smaps | grep -e "^SwapPss" | awk '{print $2}'| paste -sd+ | bc ` #SwapUsed-PSS
		#we need to be sure that we count Pss and Private memory, to avoid errors
		if [ x"$Rss" != "x" -o x"$Private" != "x" ]; 
		then

			let Shared=${Pss}-${Private}							#Shared = PSS-Private
			Name=`cat /proc/$PID/status | grep -e "^Name:" |cut -d':' -f2`			#Name
			let Sum=${Shared}+${Private}							#Sum = PSS
			#PS=`ps aux | grep -v grep | grep $PID | tr -s ' ' | cut -d' ' -f3,4,5,6`
        		#PS1=`ps -p $PID -o  min_flt,maj_flt,lstart,etime | tail -n +2` 
			x=$(( $x + 1 ))
			echo "${x},${time1},${Name},${Pss}, ${Sum}, ${Rss},${Private},${Shared1},${Shared},${Swap},${SwapPss}"
		fi
	fi
fi
}



while :
do
	if [[ ! -d /proc/$PID ]];
  	then
		break       	   #If process terminated
  	fi

	process_mem
	sleep 0.1
done | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memory.txt
