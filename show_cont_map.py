import matplotlib.pyplot as plt
import matplotlib
import numpy as np
import matplotlib as mpl
import sys

mpl.rcParams['axes.linewidth'] = 2. #set the value globally

c_mat = np.loadtxt("c_mat.out")
with open("resnames_sngl_lett.fasta", "r") as f_in:
  residues = [iresi.rstrip() for iresi in f_in]
print "###Input resiudue no###"
print residues

print "no of components of the diag: ", len(c_mat.diagonal())
print c_mat.diagonal()

fig = plt.figure()
ax = fig.add_subplot(111)

#***Read the contact matrix
cax = ax.matshow(c_mat, interpolation='nearest')

#***Set colour bar in the figure
fig.colorbar(cax)

#interval =1 
#***Overwrite tick labels (ref: http://yubais.net/doc/matplotlib/modify.html)
#plt.xticks(np.arange(0,459,interval), np.arange(1,460,interval))
#plt.yticks(np.arange(0,459,interval), np.arange(1,460,interval))
#          ^ original one             ^ the one you want to substutite into the original one.  

singl_let = [singl[0] for singl in residues]
plt.xticks(np.arange(0,459,interval), singl_let)
plt.yticks(np.arange(0,459,interval), residues)

#***
#ax.set_xlim(449.5,458.5)
#ax.set_ylim(449.5,0.5)

plt.xlim(0.5,458.5)
plt.ylim(458.5,0.5)

#plt.ylim(458.5,449.5)

plt.tight_layout()
plt.show()
#plt.savefig("contact_map.pdf", bbox_inches="tight", pad_inches=0.0)
