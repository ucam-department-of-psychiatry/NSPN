#!/bin/bash

# setup all the default folders
inDir=~/Dropbox/Research/Projects/NSPN/Data
outDir=~/Dropbox/Research/Projects/NSPN/BIDS
configDir=~/Dropbox/Research/Projects/NSPN/

#for sub in `cat subject_list.txt` ; do
for sub in 10356 ; do
	# create a new subject folder

	for sess in baseline 6_month 1st_follow_up ; do
		if [ -e ${inDir}/${sub}/${sess}/ ];then

			if [ ${sess} == "baseline" ];then
				echo "working on subject " ${sub} " - session" ${sess}
				dcm2bids -d ${inDir}/${sub}/${sess}/ -p ${sub} -s ${sess} -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ ${sess} == "6_month" ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/6Month
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/6Month
				dcm2bids -d ${inDir}/${sub}/6Month/ -p ${sub} -s 6Month -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ ${sess} == "1st_follow_up" ];then
				echo "working on subject" ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/1stFollowUp
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/1stFollowUp
				dcm2bids -d ${inDir}/${sub}/1stFollowUp/ -p ${sub} -s 1stFollowUp -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			else
				echo "session type not found"
			fi

		fi
	done

done
