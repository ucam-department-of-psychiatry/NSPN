#!/bin/bash
#
# This script takes a volumetric myelin sensitive image, and evaluates
# the intensity values along precreated intracortical surfaces. Additionally,
# it will map a annotation file to the individual subject space.
#
#
# Set up variables
# subject directory within BIDS structure

# change to overearching bids directory
topDir=/lustre/archive/q10021/NSPN/BIDS

# change to your subject list
#for sub in `cat subject_list.txt` ; do
topDir=/lustre/archive/q10021/NSPN/BIDS/derivatives/hmri
# change to your subject list
for subject in `cat fullList.txt` ; do
#for subject in sub-10356 ; do

for sess in ses-6Month ses-baseline ses-1stFollowUp ; do

	if [ -f ${topDir}/${subject}/${sess}/anat/MT.mgz ]
	then
		echo '--------------------- working on' ${subject} '---------------------'
	 	sbatch --output=/lustre/archive/q10021/NSPN/Logs/EquivSurfacesMT/${sess}_${subject}.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:40:00 --mem=4000 nspn_myelinMaptoSurf_sub.sh ${subject} ${sess}
 	else
	 echo '--------------------- subject ' ${subject} ' has no MT for this session ' ${sess} '-------------------'
	fi

done

done
