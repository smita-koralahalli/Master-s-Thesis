import math
import datetime
import matplotlib
import matplotlib.pyplot as plt
import csv

with open('tivspsi.txt','r') as f_input:
    csv_input = csv.reader(f_input, delimiter=',', skipinitialspace=True)
    x = []
    y = []
    for cols in csv_input:
        x.append(matplotlib.dates.datestr2num(cols[0]))
        y.append(float(cols[1])/1000)

# naming the x axis 
plt.xlabel('Time - hr:min:sec') 
# naming the y axis 
plt.ylabel('PSI stall time (us)') 
# giving a title to my graph 
plt.title('PSI vs Time')
# plotting the points 
plt.plot_date(x, y, marker='.', linestyle='--')
# beautify the x-labels
plt.gcf().autofmt_xdate()
# function to show the plot 
plt.show()

