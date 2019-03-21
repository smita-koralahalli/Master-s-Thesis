#!/bin/bash 

# PSI METRICS TRACKER "MEMORY", "CPU", "I/O" WITH TIME
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/psi.txt
echo PSI Statistics | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/psi.txt
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/psi.txt
x=0
process_mem ()
{
	#output1=`cat /proc/pressure/memory | cut -d' ' -f2,3,4 | sed -n 1p | tr -d '[:space:]' | cut -c 7-10,17-20,28-31 | fold -w4 | paste -sd' '`
	#output2=`cat /proc/pressure/memory | cut -d' ' -f2,3,4 | sed -n 2p | tr -d '[:space:]' | cut -c 7-10,17-20,28-31 | fold -w4 | paste -sd' '`
	#output1=`output | cut -d'=' -f1`
	time1=`date +"%T.%6N"`							     #Time in hours, minutes, seconds and milliseconds
	output1=`cat /proc/pressure/memory | cut -d' ' -f2| sed -n 1p | cut -d= -f2` #Memory(some) 10s 
	output2=`cat /proc/pressure/memory | cut -d' ' -f2| sed -n 2p | cut -d= -f2` #Memory(full) 10s
	output3=`cat /proc/pressure/memory | cut -d' ' -f3| sed -n 1p | cut -d= -f2` #Memory(some) 1m
	output4=`cat /proc/pressure/memory | cut -d' ' -f3| sed -n 2p | cut -d= -f2` #Memory(full) 1m
	output5=`cat /proc/pressure/memory | cut -d' ' -f4| sed -n 1p | cut -d= -f2` #Memory(some) 5m
	output6=`cat /proc/pressure/memory | cut -d' ' -f4| sed -n 2p | cut -d= -f2` #Memory(full) 5m
	output7=`cat /proc/pressure/memory | cut -d' ' -f5| sed -n 1p | cut -d= -f2` #Memory stall in us (accumulated some)
	output8=`cat /proc/pressure/memory | cut -d' ' -f5| sed -n 2p | cut -d= -f2` #Memory stall in us (accumulated full)
	output9=`cat /proc/pressure/cpu | cut -d' ' -f2| sed -n 1p | cut -d= -f2`    #CPU(some) 10s
	
	output10=`cat /proc/pressure/cpu | cut -d' ' -f3| sed -n 1p | cut -d= -f2`   #CPU(some) 1m
	
	output11=`cat /proc/pressure/cpu | cut -d' ' -f4| sed -n 1p | cut -d= -f2`   #CPU(some) 5m
	
	output12=`cat /proc/pressure/cpu | cut -d' ' -f5| sed -n 1p | cut -d= -f2`   #CPU stall in us (accumulated some)
	output13=`cat /proc/pressure/io | cut -d' ' -f2| sed -n 1p | cut -d= -f2`    #I/0(some) 10s
	output14=`cat /proc/pressure/io | cut -d' ' -f2| sed -n 2p | cut -d= -f2`    #I/O(full) 10s
	output15=`cat /proc/pressure/io | cut -d' ' -f3| sed -n 1p | cut -d= -f2`    #I/O(some) 1m
	output16=`cat /proc/pressure/io | cut -d' ' -f3| sed -n 2p | cut -d= -f2`    #I/O(full) 1m
	output17=`cat /proc/pressure/io| cut -d' ' -f4| sed -n 1p | cut -d= -f2`     #I/O(some) 5m
	output18=`cat /proc/pressure/io | cut -d' ' -f4| sed -n 2p | cut -d= -f2`    #I/O(full) 5m
	output19=`cat /proc/pressure/io | cut -d' ' -f5| sed -n 1p | cut -d= -f2`    #I/O stall in us (accumulated some)
	output20=`cat /proc/pressure/io | cut -d' ' -f5| sed -n 2p | cut -d= -f2`    #I/O stall in us (accumulated full)
	
	x=$(( $x + 1 ))
	echo "${x},${time1},${output1},${output2},${output3},${output4},${output5},${output6},${output7},${output8},${output9},${output10},${output11},${output12},${output13},${output14},${output15},${output16},${output17},${output18},${output19},${output20}"
}


while :
do
	process_mem
	sleep 0.1
done | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/psi.txt
