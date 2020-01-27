#!/bin/bash
topDir=/lustre/archive/q10021/NSPN/BIDS/derivatives/hmri
# change to your subject list
for subject in `cat fullList.txt` ; do
#for subject in sub-10356 ; do

for sess in ses-6Month ses-baseline ses-1stFollowUp ; do

	if [ -f ${topDir}/${subject}/${sess}/surfaces/${subject}/surf/lh.pial ]
	then
		echo '--------------------- working on' ${subject} '---------------------'
	 	sbatch --output=/lustre/archive/q10021/NSPN/Logs/EquivSurfaces/${sess}_${subject}.log --nodes=1 --ntasks=1 --cpus-per-task=1 --time=00:40:00 --mem=4000 nspn_equiSurfs.sh ${subject} ${sess}

 	else 
		echo '--------------------- subject ' ${subject} ' has no freesurfer for this session ' ${sess} '-------------------'
	fi

done
done
