#!/bin/bash
# Set local up environment
source /home/rb643/py360/bin/activate

# subject
sub=$1
subject='sub-'${sub}

# setup all the default folders
inDir=/lustre/archive/q10021/NSPN/Derived
outDir=/lustre/archive/q10021/NSPN/BIDS/derivatives/hmri
configDir=/lustre/archive/q10021/NSPN/Code

# loop through all known session naming conventions...
	for sess in baseline 6_Month 1st_Follow_Up 6Month 6_month 1st_follow_up 1stFollowUp ; do
		if [ -e ${inDir}/${sub}/${sess}/ ];then
			echo "working on subject " ${sub} " - session" ${sess}

			if [ "${sess}" = "baseline" ];then
				mkdir ${outDir}/${subject}/ses-${sess}/anat
				mkdir ${outDir}/${subject}/ses-${sess}/surfaces
				mkdir ${outDir}/${subject}/ses-${sess}/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-${sess}/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-${sess}/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-${sess}/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-${sess}/anat/

			elif [ "${sess}" = '6_Month' ];then
				mkdir ${outDir}/${subject}/ses-6Month/anat
				mkdir ${outDir}/${subject}/ses-6Month/surfaces
				mkdir ${outDir}/${subject}/ses-6Month/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-6Month/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-6Month/anat/

			elif [ "${sess}" = '6Month' ];then
				mkdir ${outDir}/${subject}/ses-6Month/anat
				mkdir ${outDir}/${subject}/ses-6Month/surfaces
				mkdir ${outDir}/${subject}/ses-6Month/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-6Month/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-6Month/anat/

			elif [ "${sess}" = '6_month' ];then
				mkdir ${outDir}/${subject}/ses-6Month/anat
				mkdir ${outDir}/${subject}/ses-6Month/surfaces
				mkdir ${outDir}/${subject}/ses-6Month/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-6Month/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-6Month/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-6Month/anat/

			elif [ "${sess}" = '1st_Follow_Up' ];then
				mkdir ${outDir}/${subject}/ses-1stFollowUp/anat
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/

			elif [ "${sess}" = '1st_follow_up' ];then
				mkdir ${outDir}/${subject}/ses-1stFollowUp/anat
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/

			elif [ "${sess}" = '1stFollowUp' ];then
				mkdir ${outDir}/${subject}/ses-1stFollowUp/anat
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces
				mkdir ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}
				cp -a ${indir}/${sub}/${sess}/. ${outDir}/${subject}/ses-1stFollowUp/surfaces/${subject}/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/R2s.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/T1.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/
				cp ${outDir}/${subject}/ses-${sess}/surfaces/${subject}/MT.mgz ${outDir}/${subject}/ses-1stFollowUp/anat/

			else
				echo "no valid sessions found for this subject"
			fi
		fi
	done
