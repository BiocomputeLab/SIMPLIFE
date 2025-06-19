#!/bin/bash

export blueprintdir=../Building_blueprint_files

export ROSETTA3=/Users/id21628/Downloads/rosetta_bin_mac_2021.16.61629_bundle/main



for file in $blueprintdir/Input_for_remodel/binX/*; do
    
    nome=$(echo $file | cut -d / -f 5)
    
    echo $nome
    
    nome=$(echo $nome | cut -d . -f 1)
    
    echo $nome
    
    mkdir Output_$nome
    
    cp $file Output_$nome
    
    cd Output_$nome
    
    mkdir {1h38_output,1cez_output}
    
    cp ../1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb 1h38_output
    cp ../Final_input_1h38.pdb 1h38_output
    cp *.blueprint 1h38_output
        
    cp ../1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb 1cez_output
    cp ../Final_input_1cez.pdb 1cez_output
    cp *.blueprint 1cez_output
    
    for f in *.blueprint; do
        
        cd 1h38_output
        
        $ROSETTA3/source/bin/remodel.macosclangrelease -database $ROSETTA3/database/ -s Final_input_1h38.pdb -out:prefix $nome  -remodel::quick_and_dirty -remodel:blueprint $f -remodel:domainFusion:insert_segment_from_pdb 1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb -out:path:all 1h38_output -remodel::num_trajectory 10 -remodel::save_top 3 -remodel::checkpoint > log_150223_1h38_$nome
        
        cd ..

        cd 1cez_output
        $ROSETTA3/source/bin/remodel.macosclangrelease -database $ROSETTA3/database/ -s Final_input_1cez.pdb -out:prefix $nome -remodel::quick_and_dirty -remodel:blueprint $f -remodel:domainFusion:insert_segment_from_pdb 1407_MinRelax_dual_Alphafold_ShortDogtagwithLinker_short.pdb  -out:path:all 1cez_output -remodel::num_trajectory 10 -remodel::save_top 3 -remodel::checkpoint > log_150223_1cez_$nome
        
        cd ..

    done
    
    cd ..


done





