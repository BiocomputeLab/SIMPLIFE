#!/bin/bash



#########Remodel part of pipeline ###################


echo Hello, please input run name
read runname


while true; do
	read -p "Want to use multi-state design? (Y/n)" yn

	case $yn in 
		[yY] ) echo multi-state design activated;
			break;;
		[nN] ) echo single-state design activated;
			break;;
		* ) echo invalid response;;
	esac

done

echo $yn


read -p "Enter path of the MAIN subdirectory in your downloaded Rosetta directory: " rosettapath

#Chech if file exist
if [ ! -e "$rosettapath" ]
then
	echo "file does not exist"
	exit
fi 


echo "Rosetta path set"

export ROSETTA3=$rosettapath



##Make the folder architecture needed
mkdir Building_blueprint_files
mkdir Remodel
mkdir Recon


####Making Blueprint files for input



##Copy the wildtype.blueprint file and Insert_specification_blueprint.py to the blueprint folder 
cp Scripts/Insert_specification_blueprint.py Building_blueprint_files
cp Input/wildtype.blueprint Building_blueprint_files
cp Input/input.txt Building_blueprint_files

cd Building_blueprint_files 

##Make new blueprint files based on the input "wildtype.blueprint" file.
##It inserts the insert into the blueprint file, with the insertion being hardcoded in the "Insert_specification_blueprint.py" file

Python3 Insert_specification_blueprint.py


#This removes some temp files
rm wildtype_*


#make a new directory for the resulting blueprint files and move files to it
mkdir Input_for_remodel 
mv Input_* Input_for_remodel

cd Input_for_remodel

#We split blueprints into 9 bins for parallelisation

for i in {1..9}; do
	mkdir bin$i 
	mv Input_$i* bin$i 
done

cd ../..
pwd

cp Scripts/Remodel_binX* Remodel
cp Scripts/Make_Remodelscripts.py Remodel
cp Scripts/jobs2run* Remodel
cp Scripts/Parallel_jobscript* Remodel

cp Input/Final_input_1cez.pdb Remodel
cp Input/Final_input_1h38.pdb Remodel
cp Input/1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb Remodel

cd Remodel

Python3 Make_Remodelscripts.py

parallel --jobs 9 < jobs2run


cd ..


#########RECON part of pipeline ###################


cd Recon
mkdir $runname

cd ../Scripts

cp Resfile_generator_final.py ../Recon/$runname
cp Recon_Script.xml ../Recon/$runname
cp Recon_binX.sh ../Recon/$runname
cp Make_Reconscripts.py ../Recon/$runname
cp reconjobs ../Recon/$runname

cd ../Input
cp recon_flags ../Recon/$runname

cd ../Remodel

#Start by copying output from Remodel into the Recon directory

for n in Output*; do
    cp -r $n ../Recon/$runname
done

#move all Remodel output files to a new directory
cd ../Recon/$runname

for j in {1..9}; do
    mkdir bin_$j
    mv Output_Input_$j* bin_$j
done


Python3 Make_Reconscripts.py

parallel --jobs 9 < reconjobs




