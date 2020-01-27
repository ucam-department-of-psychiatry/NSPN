#!/bin/bash
#
# This script takes a volumetric myelin sensitive image, and evaluates
# the intensity values along precreated intracortical surfaces. Additionally,
# it will map a annotation file to the individual subject space.
#
#
# Set up variables

# change to your subject list
#for subject in `cat subject_list.txt` ; do
for subject in 41160 ; do


	echo '------------------------------------ working on' ${subject} '-----------------------------------'

	 sbatch --output=/lustre/archive/q10021/NSPN/Logs/${subject}_BIDSConvert.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:40:00 --mem=4000 convertBids_sub.sh ${subject}


done
