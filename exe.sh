#!/bin/bash
set -eu

#echo "Calculating coms of side-chains in each residue..." 
#python make_coms_each_resi.py /Volumes/data_shinji/laminin/Analysis/traj_pdb/03_frames_removed/frm_80frame/all_rmvd_frm80.pdb
#
echo "Compling..."
gfortran make_contact_matrix.f03

echo "Executing..."
./a.out

#echo "Making the figure..."
#gnuplot make_figure.gnu

rm a.out *.mod
