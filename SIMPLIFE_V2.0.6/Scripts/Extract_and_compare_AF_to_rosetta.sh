#!/bin/bash

export Scripts=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Scripts
export ROSETTA3=/Users/id21628/Downloads/rosetta_bin_mac_2021.16.61629_bundle/main/source
export Sourcefiles=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Input
export AFinput=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Recon/relaxedinput_reconrun_06march2023/Export_folder_for_AF/energy_filtered_files/

cd /Users/id21628/Desktop/21-03_Alphafold_T7_prediction

cp $Sourcefiles/1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb /Users/id21628/Desktop/21-03_Alphafold_T7_prediction

#Change directory to the one with AF files to compare
cd /Users/id21628/Desktop/21-03_Alphafold_T7_prediction

mkdir pass_poseRMSD

mkdir final_passed_structures


for file in relaxed_d*; do

	tmp=${file#*dogcatcher_}
	name=${tmp%%_unrelaxed*}
	name=${name}.pdb



	cp ${AFinput}/$name ${AFinput}/Referernce_$name
	mv ${AFinput}/Referernce_$name /Users/id21628/Desktop/21-03_Alphafold_T7_prediction
	
	Ref=Referernce_$name
	#Script for sorting based on global superposition
	echo $Ref

	#$ROSETTA3/bin/rosetta_scripts.macosclangrelease -s $file -parser:protocol ${Scripts}/RMSD_Scoring_AF-to-pose.xml -out:file:scorefile RMSD.sc -parser:script_vars reference=$Ref -out:no_nstruct_label 1 -out:prefix poseRMSD_ -overwrite
	#$ROSETTA3/bin/rosetta_scripts.macosclangrelease -s $file -parser:protocol ${Scripts}/RMSD_Scoring_AF-to-pose_del4.xml -out:file:scorefile RMSD.sc -parser:script_vars reference=$Ref -out:no_nstruct_label 1 -out:prefix poseRMSD_ -overwrite
	

	#script for sorting based on superposition of insert only 
	
	#cp poseRMSD_$file pass_poseRMSD/  
	

	#extract location
	tmp2=${name%%_00*}
	loc=${tmp2#*1h38_}
	#echo $loc

	loc_ez=${tmp2#*1cez_}

	len=${#loc}
	len_ez=${#loc_ez}

	#echo $len

	if [[ $len -le 6 ]]; then
		if [[ $len -eq 6 ]]; then 
			location=$(echo $loc | cut -c 1-3)
		elif [[ $len -eq 5 ]]; then
			location=$(echo $loc | cut -c 1-2)
		elif [[ $len -eq 4 ]]; then
			location=$(echo $loc | cut -c 1-2)
		elif [[ $len -eq 2 ]]; then
			location=$(echo $loc | cut -c 1)
		else
			location="not defined"
		fi

	fi




	if [[ $len_ez -le 6 ]]; then
		if [[ $len_ez -eq 6 ]]; then 
			location=$(echo $loc_ez | cut -c 1-3)
		elif [[ $len_ez -eq 5 ]]; then
			location=$(echo $loc_ez | cut -c 1-2)
		elif [[ $len_ez -eq 4 ]]; then
			location=$(echo $loc_ez | cut -c 1-2)
		elif [[ $len_ez -eq 2 ]]; then
			location=$(echo $loc_ez | cut -c 1)
		else
			location="not defined"
		fi

	fi 


	echo $location  



	#Assuming insert length of 25 residues with 3 residue linker sequences on either side 
	((input_location=$location+8))
	((endaftinsert=$location+22))

	$ROSETTA3/bin/rosetta_scripts.macosclangrelease -s poseRMSD_$file -parser:protocol ${Scripts}/RMSD_Scoring_AF-to-insert.xml -out:file:scorefile RMSD_insert.sc -parser:script_vars reference=$Ref start=$input_location end=$endaftinsert -out:no_nstruct_label 1 -out:prefix insertRMSD_ -overwrite
	
	#cp /home/georgiehs/Desktop/Best_AF_estimate/Referernce_$file /home/georgiehs/Desktop/Best_AF_estimate/Referernce_poseRMSD_$file

done  

#cp insertRMSD* final_passed_structures/

#for f in pass_poseRMSD/poseRMSD*; do 
#	#extract location
#	temp=${f%%_00*}
#	loc=${temp#*RMSD_}
#	
#	echo $loc
#	((location=$loc+3))
#	((endaftinsert=$loc+20))
#	Ref=Referernce_poseRMSD_
#
#	echo $Ref
	#Script for sorting based on insert superposition
#	$ROSETTA3/bin/rosetta_scripts.default.linuxgccrelease -s $f -parser:protocol /home/georgiehs/Desktop/Loop_Insertion_with_Anchor/RMSD_Scoring_AF-to-insert.xml -out:file:scorefile RMSD_insert.sc -parser:script_vars reference=$Ref start=$location end=$endaftinsert -out:no_nstruct_label 1 -out:suffix _insertRMSD
#	cp *insertRMSD.pdb final_passed_structures/
	

	
	
#	done 
#done
    
	
#Set score =5 for global, =2.5 for local


#Measurements: Compare AF to Rosetta structures
#control-group: Compare two Rosetta strucutres from same position










