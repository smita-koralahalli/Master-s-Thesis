import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
from cycler import cycler


# Read latencies
data1 = np.loadtxt('latency.txt')
x1 = np.sort(data1)
y1 = np.arange(1, len(x1)+1)/float(len(x1))
f1 = interp1d(x1, y1)
print("95 percentile: %f" % np.percentile(x1,95))
print("98 percentile: %f" % np.percentile(x1,98))
print("median: %f" % np.percentile(x1,50))



# Plot CDF of latencies
f, ax = plt.subplots()
cy = cycler('color', ['blue'])
ax.set_prop_cycle(cy)
ax.plot(x1,f1(x1), '--', marker= '.')
plt.xlabel('Latency (s)')
plt.ylabel('CDF')
plt.legend(['SWAPOFF'], loc='best')  
plt.title('Latency CDF') 

plt.show()

