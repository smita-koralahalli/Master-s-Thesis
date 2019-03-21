#!/bin/bash 

# Memory Statistics of the system when process running
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memstat.txt
echo Memory Statistics | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memstat.txt
echo "-----------------------------------------------------------------------------------------------------------------" | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memstat.txt
x=0
process_mem ()
{
	time1=`date +"%T.%6N"`							     #Time in hours, minutes, seconds and milliseconds
	TotalRAM=`free -k | tr -s ' ' | cut -d' ' -f2 | sed -n 2p`		     #Total RAM
	FreeRAM=`free -k | tr -s ' ' | cut -d' ' -f4 | sed -n 2p`		     #Free RAM
	Freep=$( printf '%.02f' $(echo "$FreeRAM / $TotalRAM * 100" | bc -l) )	     #Free RAM percentage
	UsedRAM=`free -k | tr -s ' ' | cut -d' ' -f3 | sed -n 2p`		     #Used RAM
	Usedp=$( printf '%.02f' $(echo "$UsedRAM / $TotalRAM * 100" | bc -l) )       #Used RAM percentage
        AvailableRAM=`free -k | tr -s ' ' | cut -d' ' -f7 | sed -n 2p`		     #Available RAM
	Availablep=$( printf '%.02f' $(echo "$AvailableRAM / $TotalRAM * 100" | bc -l) ) #Available RAM percentage
        SharedRAM=`free -k | tr -s ' ' | cut -d' ' -f5 | sed -n 2p`		         #Shared RAM
	Sharedp=$( printf '%.02f' $(echo "$SharedRAM / $TotalRAM * 100" | bc -l) )       #Shared RAM percentage
	BufferRAM=`vmstat -S K | tr -s ' ' | cut -d' ' -f6 | sed -n 3p`                  #Buffer RAM
	Bufferp=$( printf '%.02f' $(echo "$BufferRAM / $TotalRAM * 100" | bc -l) )	 #Buffer RAM percentage
	CacheRAM=`vmstat -S K | tr -s ' ' | cut -d' ' -f7 | sed -n 3p`			 #Cache RAM
	Cachep=$( printf '%.02f' $(echo "$CacheRAM / $TotalRAM * 100" | bc -l) )         #Cache RAM percentage
	TotalSwap=`free -k | tr -s ' ' | cut -d' ' -f2 | sed -n 3p`			 #Total Swap
	UsedSwap=`free -k | tr -s ' ' | cut -d' ' -f3 | sed -n 3p`  			 #Used Swap
	AvailableSwap=`free -k | tr -s ' ' | cut -d' ' -f4 | sed -n 3p`			 #Availabale Swap
	Usedswapp=$( printf '%.02f' $(echo "$UsedSwap / $TotalSwap * 100" | bc -l) )	 #Used Swap
	
	x=$(( $x + 1 ))
	echo "${x},${time1},${TotalRAM},${FreeRAM},$Freep,${UsedRAM},$Usedp,${AvailableRAM},$Availablep,${SharedRAM},$Sharedp,${BufferRAM},$Bufferp,${CacheRAM},$Cachep,${TotalSwap},${UsedSwap},${AvailableSwap},$Usedswapp"
	
}


while :
do
	process_mem
	sleep 0.1
done | tee -a /home/edge_computing/Documents/THESIS_SMITA/thesis/Results/memstat.txt
