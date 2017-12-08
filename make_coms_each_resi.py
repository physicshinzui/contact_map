from MDAnalysis import Universe
import numpy as np
import sys
import os
import glob
import time

"""
Usage: python sys.argv[0] [INPUT file.pdb]
"""

input_traj = sys.argv[1]
u = Universe(input_traj)

sele = "segid A B C and not backbone" 

#***save atom groups selected
sele_grps = u.select_atoms(sele)
print "Saved groups: ", sele_grps.residues

no_of_coloums = len(sele_grps.residues)
no_of_rows    = len(sele_grps.residues)

#***Make a zero matrix 
c_mat = np.zeros([no_of_rows,no_of_coloums])
print "Shape of the matrix, c_mat: ", np.shape(c_mat)

start_time = time.time()
#***Count contacts in each residue
with open("com.out", "w") as fout:
  for itr, frame in enumerate(u.trajectory, 1):
    print itr
    fout.write("MODEL {0} \n".format(itr))
    for i, iresi in enumerate(sele_grps.residues):
      com = iresi.atoms.center_of_mass()
      fout.write("{0} {1} {2} {3} {4} \n".format(iresi.resid, iresi.resname, com[0],com[1],com[2]))
    fout.write("ENDMDL \n")

#  for i, iresi in enumerate(sele_grps.residues):
#    sys.stdout.write("\r%d" % i)
#    sys.stdout.flush()
#    for j, jresi in enumerate(sele_grps.residues):
#      icom, jcom = iresi.atoms.center_of_mass(), jresi.atoms.center_of_mass()
#      dr = np.linalg.norm(icom - jcom)
#      if dr <= 5.0:
#        c_mat[j,i] = c_mat[j,i] + 1
#  print("--- %s seconds ---" % (time.time() - start_time))
np.savetxt("c_mat.txt", c_mat, fmt='%i') #NOTE THIS
