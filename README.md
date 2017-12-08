
#Calculating coms of side-chains in each residue...
python make_coms_each_resi.py [INPUT Trajectory.pdb]

#Complie
gfortran make_contact_matrix.f03

#Executing
./a.out

#show the contact map
python show_cont_map.py 
