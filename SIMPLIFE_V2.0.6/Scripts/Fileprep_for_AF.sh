#!/bin/bash

export scriptdir=/Users/id21628/Desktop/SIMPLIFE_2_testbed/Scripts


cd Recon

#######Insert user prompt part here
#!/bin/bash
prompt="Please select a file:"
options=( $(find . -maxdepth 1 -type d -print0 | xargs -0) )

PS3="$prompt "
select opt in "${options[@]}" "Quit" ; do
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done

#ls -ld "$opt"
cd $opt

mkdir Export_folder_for_AF

##Loops through bins
for bin in bin*/; do

    cd $bin
    

    for dir in */; do
        
        ######## Entering location-specific directory#########
        
        echo $dir
        cd $dir
        
        for pdb in E*; do
            ####Specify name
            name=$(echo $pdb | cut -d . -f 1)
            #convert pdb to fasta
            python3 $scriptdir/pdb2fasta.py $pdb > $name.fasta
        
            curdir=$(pwd)
            ###run python script to sort duplicates. Fasta files that arenique are outputted into the Unique_sequences_for_AF.txt file
            python3 $scriptdir/Check_fasta_for_duplicates.py $curdir
            
        done
            
        #Copy unique files, specidfied by Unique_sequences_for_AF.txt to export folder
        for filenome in $(cat Unique_sequences_for_AF.txt); do
            echo $filenome
            cp $filenome ../../Export_folder_for_AF
            nme=$(echo $filenome | cut -d . -f 1)
            nme=$nme.pdb
            cp $nme ../../Export_folder_for_AF
        done

        
        
        
        ######## Leaving location-specific directory##########
        cd ..
        
    done
    
    cd ..

done





