#!/bin/bash

# change to overearching bids directory
baseDir=/lustre/archive/q10021/NSPN/BIDS/derivatives/hmri
baseOut=/lustre/archive/q10021/NSPN/BIDS/derivatives/equivSurfs
# create all output directories
mkdir -p ${baseOut}
mkdir -p ${baseOut}/${subn}
mkdir -p ${baseOut}/${subn}/${sess}
mkdir -p ${baseOut}/${subn}/${sess}/surfaces
mkdir -p ${baseOut}/${subn}/${sess}/surfaces/equivSurfs

module load freesurfer

	subn=$1
	sess=$2
	# change to conform with your folder structure - should direct to the freesurfer surf folder and a new output folder
	export SUBJECTS_DIR=${baseDir}/${subn}/${sess}/surfaces
	export TMPDIR=/lustre/scratch/wbic-beta/rb643/temp

	# change to conform with your folder structure - should direct to the freesurfer surf folder and a new output folder
	dataDir=${baseDir}/${subn}/${sess}/surfaces/${subn}/surf
	outDir=${baseOut}/${subn}/${sess}/surfaces/equivSurfs

	# necessary to construct multiple sets of surfaces, with a range of surfafce numbers for optimisation
	for num_surfs in 10 12 14 ; do

		# set output directory and create directory if necessary
		mkdir -p ${outDir}/${num_surfs}surfs

		for hemi in lh rh ; do
			python /lustre/archive/q10021/NSPN/Code/Utils/surface_tools/equivolumetric_surfaces/generate_equivolumetric_surfaces.py ${dataDir}/${hemi}.pial ${dataDir}/${hemi}.white ${num_surfs} ${outDir}/${num_surfs}surfs/${hemi}_equiv_${num_surfs}surfs --software freesurfer --subject_id ${subn}
		done

	done
