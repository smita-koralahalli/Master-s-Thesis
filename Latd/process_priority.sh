#!/bin/sh

x=0
process_mem ()
{
	time1=`date +"%T.%6N"`							     #Time in hours, minutes, seconds and milliseconds
	output1=` ps -eo rtprio,nice,comm | grep python3`
	output2=` ps -eo rtprio,nice,comm | grep oom`
	
	x=$(( $x + 1 ))
	echo "${x},${time1},${output1},${output2}"
}


while :
do
	process_mem
	sleep 0.1
done | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/nice.txt

