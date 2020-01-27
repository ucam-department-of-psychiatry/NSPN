#!/bin/bash
#
# This script takes a volumetric myelin sensitive image, and evaluates
# the intensity values along precreated intracortical surfaces. Additionally,
# it will map a annotation file to the individual subject space.
#
#
# Set up variables
module load freesurfer

# subject directory within BIDS structure
subject=$1
sess=$2

# change to overearching bids directory
topDir=/lustre/archive/q10021/NSPN/BIDS/derivatives/
lhAnnot=/lustre/archive/q10021/NSPN/Code/Utils/templates/lh.HCP.fsaverage.aparc.annot
rhAnnot=/lustre/archive/q10021/NSPN/Code/Utils/templates/rh.HCP.fsaverage.aparc.annot

baseDir=${topDir}/equivSurfs/${subject}/${sess}/
myeImage=${topDir}/hmri/${subject}/${sess}/anat/MT.mgz

# set up and make necessary subfolders
myeDir="$baseDir"/ProcessingMyeSurfaces
warpDir="$baseDir"/xfms
for thisDir in $myeDir $warpDir ; do
        [[ ! -d "$thisDir" ]] && mkdir "$thisDir"
done

export SUBJECTS_DIR=${topDir}/hmri/${subject}/${sess}/surfaces
export TMPDIR=/lustre/scratch/wbic-beta/rb643/temp

# Register to Freesurfer space
bbregister --s "$subject" --mov "$myeImage" --reg "$warpDir"/"$subject"_mye2fs_bbr.lta --init-fsl --t1

# Register to surface
for num_surfs in 10 12 14 ; do

	for hemi in l r; do
		# find all equivolumetric surfaces and list by creation time
		x=$(ls -t "$baseDir"/surfaces/equivSurfs/"$num_surfs"surfs/${hemi}*)

		for n in $(seq 1 1 "$num_surfs") ; do

			# select a surfaces and copy to the freesurfer directory
			which_surf=$(sed -n "$n"p <<< "$x")
			cp "$which_surf" "$SUBJECTS_DIR"/"$subject"/surf/"$hemi"h."$n"by"$num_surfs"surf

		    # project intensity values from volume onto the surface
			mri_vol2surf \
					--mov "$myeImage" \
					--reg "$warpDir"/"$subject"_mye2fs_bbr.lta \
					--hemi "$hemi"h \
					--out_type mgh \
					--trgsubject "$subject" \
					--out "$myeDir"/"$hemi"h."$n"by$num_surfs.mgh \
					--surf "$n"by"$num_surfs"surf

		done

	done

done

# create symbolic link to fsaverage within the subject's directory
ln -s $FREESURFER_HOME/subjects/fsaverage $SUBJECTS_DIR

# map annotation to subject space
mri_surf2surf --srcsubject fsaverage --trgsubject $subject --hemi lh \
    --sval-annot $lhAnnot \
    --tval       $SUBJECTS_DIR/"$subject"/label/lh.HCP.fsaverage.aparc.annot
mri_surf2surf --srcsubject fsaverage --trgsubject $subject --hemi rh \
    --sval-annot $rhAnnot \
    --tval       $SUBJECTS_DIR/"$subject"/label/rh.HCP.fsaverage.aparc.annot
