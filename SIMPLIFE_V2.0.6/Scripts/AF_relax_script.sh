#!/bin/bash

export ROSETTA3=/Users/id21628/Downloads/rosetta_bin_mac_2021.16.61629_bundle/main

export Scripts=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Scripts


##Handmade wait -n function
wait-n ()
{ StartJobs="$(jobs -p)"

CurJobs="$(jobs -p)"
while diff -q <(echo -e "$StartJobs") <(echo -e "$CurJobs") >/dev/null
do
	sleep 1
	CurJobs="$(jobs -p)"
done
}






N=10

while IFS= read -r line; do
	(###do commands here

	name=$(echo $line | cut -d . -f 1)

	echo $name

	name=${name}.pdb

	$ROSETTA3/source/bin/rosetta_scripts.macosclangrelease -s $name -parser:protocol ${Scripts}/Alphafold_relax_for_input.xml -out:prefix relaxed_ -restore_talaris_behavior
	echo "relaxing $name"

	sleep $(( (RANDOM %3) +1))

	) &

	if [[ $(jobs -r -p | wc -l) -ge $N ]] ; then 
		wait-n 

	fi 

done < files_to_relax.txt

wait 

echo "all done"

