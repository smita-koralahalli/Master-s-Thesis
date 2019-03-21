import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d
from cycler import cycler
import matplotlib
matplotlib.rcParams['pdf.fonttype'] = 42
matplotlib.rcParams['ps.fonttype'] = 42

# Read latencies
data1 = np.loadtxt('pytorchlatency20.txt')
x1 = np.sort(data1)
y1 = np.arange(1, len(x1)+1)/float(len(x1))
f1 = interp1d(x1, y1)
print("95 percentile of 20 swap: %f" % np.percentile(x1,95))
print("98 percentile of 20 swap: %f" % np.percentile(x1,98))
print("median of 20 swap: %f" % np.percentile(x1,50))

data2 = np.loadtxt('pytorchlatency40.txt')
x2 = np.sort(data2)
y2 = np.arange(1, len(x2)+1)/float(len(x2))
f2 = interp1d(x2, y2)
print("95 percentile of 40 swap: %f" % np.percentile(x2,95))
print("98 percentile of 40 swap: %f" % np.percentile(x2,98))
print("median of 40 swap: %f" % np.percentile(x2,50))

data3 = np.loadtxt('pytorchlatency60.txt')
x3 = np.sort(data3)
y3 = np.arange(1, len(x3)+1)/float(len(x3))
f3 = interp1d(x3, y3)
print("95 percentile of 60 swap: %f" % np.percentile(x3,95))
print("98 percentile of 60 swap: %f" % np.percentile(x3,98))
print("median of 40 swap: %f" % np.percentile(x3,50))

data4 = np.loadtxt('pytorchlatency80.txt')
x4 = np.sort(data4)
y4 = np.arange(1, len(x4)+1)/float(len(x4))
f4 = interp1d(x4, y4)
print("95 percentile of 80 swap: %f" % np.percentile(x4,95))
print("98 percentile of 80 swap: %f" % np.percentile(x4,98))
print("median of 80 swap: %f" % np.percentile(x4,50))

data5 = np.loadtxt('pytorchlatency90.txt')
x5 = np.sort(data5)
y5 = np.arange(1, len(x5)+1)/float(len(x5))
f5 = interp1d(x5, y5)
print("95 percentile of 90 swap: %f" % np.percentile(x5,95))
print("98 percentile of 90 swap: %f" % np.percentile(x5,98))
print("median of 90 swap: %f" % np.percentile(x5,50))

data6 = np.loadtxt('pytorchlatency100.txt')
x6 = np.sort(data6)
y6 = np.arange(1, len(x6)+1)/float(len(x6))
f6 = interp1d(x6, y6)
print("95 percentile of 100 swap: %f" % np.percentile(x6,95))
print("98 percentile of 100 swap: %f" % np.percentile(x6,98))
print("median of 100 swap: %f" % np.percentile(x6,50))


f, ax = plt.subplots(2, 3)
ax[0,0].plot(x1,f1(x1),marker='.', linestyle='-')
ax[0,0].set_title('Latency CDF-20% swap') 
ax[0,0].set_xlabel('Latency(s)')
ax[0,0].set_ylabel('CDF')

ax[0,1].plot(x2,f2(x2),marker='.', linestyle='-')
ax[0,1].set_title('Latency CDF-40% swap') 
ax[0,1].set_xlabel('Latency(s)')
ax[0,1].set_ylabel('CDF')
 
ax[0,2].plot(x3,f3(x3),marker='.', linestyle='-')
ax[0,2].set_title('Latency CDF-60% swap') 
ax[0,2].set_xlabel('Latency(s)')
ax[0,2].set_ylabel('CDF')

ax[1,0].plot(x4,f4(x4),marker='.', linestyle='-')
ax[1,0].set_title('Latency CDF-80% swap') 
ax[1,0].set_xlabel('Latency(s)')
ax[1,0].set_ylabel('CDF')

ax[1,1].plot(x5,f5(x5),marker='.', linestyle='-')
ax[1,1].set_title('Latency CDF-90% swap') 
ax[1,1].set_xlabel('Latency(s)')
ax[1,1].set_ylabel('CDF')


ax[1,2].plot(x6,f6(x6),marker='.', linestyle='-')
ax[1,2].set_title('Latency CDF-100% swap') 
ax[1,2].set_xlabel('Latency(s)')
ax[1,2].set_ylabel('CDF')


plt.show()

