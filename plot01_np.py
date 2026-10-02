import numpy as np
import matplotlib.pyplot as plt
import os, sys

# PARAMETROS

largo = 270
largo = 200


# LECTURA NOMBRE ESTACIONES

stn_file = sys.argv[1]

with open(stn_file,'r') as f:
    lines = f.readlines()
    lines = lines[5:]

TXT = os.listdir('.')
TXT = [l for l in TXT if l[-4:] == '.txt']


OUT = []
for l in lines:
    stn = l.rsplit()[2]
    txtfile = stn + '.0'
    OUT.append(txtfile)
    print(txtfile)


fig = plt.figure()
ntraces = len(OUT)

#PLOTEO 
for i,txtfile in enumerate(OUT):
    ax1 = fig.add_subplot(ntraces,1, i+1)

    data = np.loadtxt(txtfile)

    x = data[:,0]
    y = data[:,1]

    stn = txtfile.rsplit('.')[0]
    if i == 0:
        ax1.set_title('Sinteticos')
    ax1.plot(x[0:largo],y[0:largo]/100., label=stn)
    ax1.legend(prop={'size':8})


    if i == len(OUT) - 1:
        ax1.set_xlabel('[s]')
    else:
        ax1.axes.xaxis.set_ticklabels([])

    ax1.grid()

    ot = [l for l in TXT if stn in l][0]
    datao = np.loadtxt(ot)

    # Grafico waveform
    yo = datao
    x = np.linspace(0,len(yo)/4,len(yo) + 1)[:-1]  #datos sin tiempo 
    ax1.plot(x[0:largo],yo[0:largo], label=stn)

    print('RMS ' + stn, np.sqrt((np.sum(y[:largo]-yo[:largo])**2)/sum(yo[:largo]**2)))

plt.show()

