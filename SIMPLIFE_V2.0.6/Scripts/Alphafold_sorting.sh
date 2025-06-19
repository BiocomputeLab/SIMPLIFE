#!/bin/bash

export Scripts=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Scripts

curdir=pwd

for dir in *.result/*; do

	for file in $dir; do

		if [[ $file =~ "0.json" ]] ; then

			python3 $Scripts/AlphaFold_output_sorting.py $file

		else

			echo "File not found"

		fi

	done

done
