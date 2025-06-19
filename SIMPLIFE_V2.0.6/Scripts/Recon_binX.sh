##### script to be parallelisised


for dir in bin_X/*; do
    
    cp Resfile_generator_final.py $dir
    cp recon_flags $dir
    cp Recon_ScriptV3.xml $dir
    
    cd $dir
    
    Start=$(echo $dir | cut -d _ -f 4)
    End=$(echo $dir | cut -d _ -f 5)
    name=$(echo $dir | cut -d _ -f 3,4,5)
    
    cd 1h38_output
    
    
    echo "Start $Start"
    echo "End $End"
    echo "Name $name"
    
    
    if test -f "${name}_1.pdb" ; then
    cp *_1.pdb Best_1_1h38_$Start$End.pdb
    mv Best_1_1h38_$Start$End.pdb ..
    fi
    
    if test -f "${name}_2.pdb" ; then
    cp *_2.pdb Best_2_1h38_$Start$End.pdb
    mv Best_2_1h38_$Start$End.pdb ..
    fi
    
    if test -f "${name}_3.pdb" ; then
    cp *_3.pdb Best_3_1h38_$Start$End.pdb
    mv Best_3_1h38_$Start$End.pdb ..
    fi
    
    cd ..
    
    cd 1cez_output
    if test -f "${name}_1.pdb" ; then
    cp *_1.pdb Best_1_1cez_$Start$End.pdb
    mv Best_1_1cez_$Start$End.pdb ..
    fi
    
    if test -f "${name}_2.pdb" ; then
    cp *_2.pdb Best_2_1cez_$Start$End.pdb
    mv Best_2_1cez_$Start$End.pdb ..
    fi
    
    if test -f "${name}_3.pdb" ; then
    cp *_3.pdb Best_3_1cez_$Start$End.pdb
    mv Best_3_1cez_$Start$End.pdb ..
    fi
    
    cd ..

    
    if test -f "Best_1_1h38_$Start$End.pdb" && test -f "Best_1_1cez_$Start$End.pdb" ; then
            echo "Model candidate 1"
            
            #####Make resfile script
            
            Python3 Resfile_generator_final.py $Start $End
            
            
            #####Recon script
            
            #A blueprint file is generated on the basis of the finished Remodel pdb to calculate the length of the engineered protein
            $ROSETTA3/demos/public/design_with_flex_loops/scripts/getBluePrintFromCoords.pl -pdbfile Best_1_1h38_$Start$End.pdb > blueprintafterinsert.blueprint
            
            #The length is found by the wc -l command, counting the number of lines in the blueprint file. The result is cut to only include the numerical value for the number of lines
            lngth=$(wc -l blueprintafterinsert.blueprint)
            length=$(cut -d' ' -f1 <<< $lngth)
        
            #Defining the other important residue numbers for the insert
            ((startlp=$Start-1))
            ((strtins=$startlp+6))
            ((endins=$startlp+25))
            ((endlp=$startlp+31))
            
            echo $startlp
            echo $strtins
            echo $endins
            echo $endlp
            echo $length
            
            
            $ROSETTA3/source/bin/recon.default.macosclangrelease @recon_flags -s Best_1_1h38_$Start$End.pdb Best_1_1cez_$Start$End.pdb -parser:protocol Recon_ScriptV3.xml -out:prefix E1_ -scorefile simplife_${runname}_${Start}_${End}.fasc -parser:script_vars res_file=resfile_${Start}_${End}.res startloop=$startlp startinsert=$strtins endafterinsert=$endins endloop=$endlp Length=$length
    
    fi
    
    
    if test -f "Best_2_1h38_$Start$End.pdb" && test -f "Best_2_1cez_$Start$End.pdb" ; then
        
            echo "Model candidate 2"
            
            $ROSETTA3/source/bin/recon.default.macosclangrelease @recon_flags -s Best_2_1h38_$Start$End.pdb Best_2_1cez_$Start$End.pdb -parser:protocol Recon_ScriptV3.xml -out:prefix E2_ -scorefile simplife_${runname}_${Start}_${End}.fasc -parser:script_vars res_file=resfile_${Start}_${End}.res startloop=$startlp startinsert=$strtins endafterinsert=$endins endloop=$endlp Length=$length
            
    
    
    fi
    
    
    
    if test -f "Best_3_1h38_$Start$End.pdb" && test -f "Best_3_1cez_$Start$End.pdb" ; then
        
            echo "Model candidate 3"
            
            $ROSETTA3/source/bin/recon.default.macosclangrelease @recon_flags -s Best_3_1h38_$Start$End.pdb Best_3_1cez_$Start$End.pdb -parser:protocol Recon_ScriptV3.xml -out:prefix E3_ -scorefile simplife_${runname}_${Start}_${End}.fasc -parser:script_vars res_file=resfile_${Start}_${End}.res startloop=$startlp startinsert=$strtins endafterinsert=$endins endloop=$endlp Length=$length
            
    
    fi
    
    
    
    cd ../..

    
    
done
