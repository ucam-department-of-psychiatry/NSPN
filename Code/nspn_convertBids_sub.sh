#!/bin/bash
# Set up environment
source /home/rb643/py360/bin/activate

# subject 
sub=$1

# setup all the default folders
inDir=/lustre/archive/q10021/NSPN/MPM
outDir=/lustre/archive/q10021/NSPN/BIDS
configDir=/lustre/archive/q10021/NSPN/Code

	for sess in baseline 6_Month 1st_Follow_Up 6Month 6_month 1st_follow_up 1stFollowUp ; do
		if [ -e ${inDir}/${sub}/${sess}/ ];then

			if [ "${sess}" = "baseline" ];then
				echo "working on subject " ${sub} " - session" ${sess}
				dcm2bids -d ${inDir}/${sub}/${sess}/ -p ${sub} -s ${sess} -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '6_Month' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/6Month
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/6Month
				dcm2bids -d ${inDir}/${sub}/6Month/ -p ${sub} -s 6Month -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '6Month' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/6Month
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/6Month
				dcm2bids -d ${inDir}/${sub}/6Month/ -p ${sub} -s 6Month -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '6_month' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/6Month
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/6Month
				dcm2bids -d ${inDir}/${sub}/6Month/ -p ${sub} -s 6Month -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '1st_Follow_Up' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/1stFollowUp
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/1stFollowUp
				dcm2bids -d ${inDir}/${sub}/1stFollowUp/ -p ${sub} -s 1stFollowUp -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '1st_follow_up' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/1stFollowUp
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/1stFollowUp
				dcm2bids -d ${inDir}/${sub}/1stFollowUp/ -p ${sub} -s 1stFollowUp -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			elif [ "${sess}" = '1stFollowUp' ];then
				echo "working on subject " ${sub} " - session" ${sess}
				mkdir ${inDir}/${sub}/1stFollowUp
				mv ${inDir}/${sub}/${sess}  ${inDir}/${sub}/1stFollowUp
				dcm2bids -d ${inDir}/${sub}/1stFollowUp/ -p ${sub} -s 1stFollowUp -c ${configDir}/bids_nspn_config2.json -o ${outDir}
			else
				echo "session type not found"
			fi

		fi
	done

