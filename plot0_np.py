import numpy as np
import matplotlib.pyplot as plt
import sys

# PARAMETROS

largo = 300 #200


# LECTURA NOMBRE ESTACIONES

stn_file = sys.argv[1]
print(stn_file)


with open(stn_file,'r') as f:
    lines = f.readlines()
    lines = lines[5:]

TXT = []
for l in lines:
    stn = l.rsplit()[2]
    txtfile = stn + '.0'
    TXT.append(txtfile)
    print(txtfile)


fig = plt.figure()
ntraces = len(TXT)

#PLOTEO 
for i,txtfile in enumerate(TXT):
    ax1 = fig.add_subplot(ntraces,1, i+1)

    data = np.loadtxt(txtfile)
    x = data[:,0]
    y = data[:,1]

    stn = txtfile 
    ax1.set_title('SINTETICOS')
    ax1.set_xlabel('[s]')
    ax1.plot(x[0:largo],y[0:largo], label=stn)
    ax1.legend(prop={'size':10})

plt.show()

