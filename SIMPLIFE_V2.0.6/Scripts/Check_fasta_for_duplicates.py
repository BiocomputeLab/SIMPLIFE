import os
import itertools
import sys


directory_from_shell=sys.argv[1]

#Definenes a function to read the nth line of a file:
def read_nth_line_isl(filepath: str, n: int, encoding="utf-8") -> str:
    		with open(filepath, "r", encoding=encoding) as file_obj:
        		return next(itertools.islice(file_obj, n, n + 1), None)

#Sets directory (should be changed to take input from bash script)
directory=directory_from_shell


#Loops through .fasta files in directory, adds fasta sequence and filename to dictionary as a pair
temp_dict={}

for file in os.listdir(directory):
	filename=os.fsdecode(file)
	if filename.endswith(".fasta"):
		#print(filename)
		sequence=read_nth_line_isl(filename, 1)
		temp_dict[filename]=sequence
  
   
# Remove duplicate values in dictionary
temp = []
result = dict()
for key, val in temp_dict.items():
    if val not in temp:
        temp.append(val)
        result[key] = val
 


unique_list=[]
for key in result:
    unique_list.append(key)
    
with open('Unique_sequences_for_AF.txt', 'w') as f:
    f.write('\n'.join(unique_list))
    





