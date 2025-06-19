#To be called from within genberal folder


#changes to filepath for the AF export
mkdir renamed_fasta

counter=1

for f in *.fasta; do
		
    
    Position=$(echo $f | cut -d _ -f 5)

   	if [ ${#Position} == 6 ] ; then
   		firstloop=$(echo $Position | cut -c1-3)

   	elif [ ${#Position} -le 5 ] ; then
   		firstloop=$(echo $Position | cut -c1-2)

   	else
   		echo "char out of range"
   	fi
    
    echo "Postition" $Position
    echo "Loopstart" $firstloop

    cp $f ${counter}_${firstloop}.fasta
    mv ${counter}_${firstloop}.fasta renamed_fasta  


	counter=$((counter+1))
	


done


cd renamed_fasta

for file in *.fasta; do
    nome=$(echo $file | cut -d _ -f 2)

    cat $file >> concat_$nome
    
    Concatfile=concat_$nome
    
done


for con in concat*; do

    

    if [[ -n $con ]] ; then
    
        python3 /Users/id21628/Desktop/SIMPLIFE_2_testbed/Scripts/Phylotrees_AFinput.py $con
    
    elif [[ -z $con ]] ; then
        echo "File is empty"
    
    fi

done
