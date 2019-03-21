import math
import datetime
import matplotlib
import matplotlib.pyplot as plt
import csv
import numpy as np
from scipy.interpolate import interp1d
from cycler import cycler


with open('tvsmemstat.txt','r') as f_input:
    csv_input = csv.reader(f_input, delimiter=',', skipinitialspace=True)
    x = []
    y1 = []
    y2 = []
    y3 = []
    y4 = []
    y5 = []
    y6 = []
    for cols in csv_input:
        x.append(matplotlib.dates.datestr2num(cols[0]))
        y1.append(float(cols[1]))  #Free Memory
        y2.append(float(cols[3]))  #Available Memory
        y3.append(float(cols[4]))  #Shared Memory
        y4.append(float(cols[5]))  #Buffer Memory
        y5.append(float(cols[6]))  #Cached Memory
        y6.append(float(cols[7]))  #Swap
f, ax = plt.subplots()
cy = cycler('color', ['red', 'green', 'orange', 'magenta', 'yellow', 'cyan'])
ax.set_prop_cycle(cy)
ax.plot_date(x,y1,marker='.', linestyle='-')
ax.plot_date(x,y2,marker='.', linestyle='-')
ax.plot_date(x,y3,marker='.', linestyle='-')
ax.plot_date(x,y4,marker='.', linestyle='-')
ax.plot_date(x,y5,marker='.', linestyle='-')
ax.plot_date(x,y6,marker='.', linestyle='-')

# naming the x axis 
plt.xlabel('Time - hrs:min:sec') 

# naming the y axis 
plt.ylabel('Memory (%)') 

plt.legend(['Free Memory', 'Available Memory', 'Shared Memory', 'Buffer Memory', 'Cached Memory', 'Swap'], loc='best') 

# giving a title to my graph 
plt.title('Memory vs Time UNDER PRESSURE')

#beautify x-axis
plt.gcf().autofmt_xdate()

# function to show the plot 
plt.show()





