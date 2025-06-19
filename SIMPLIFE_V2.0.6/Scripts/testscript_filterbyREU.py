import shutil
import sys




filename=sys.argv[1]
boundary=sys.argv[2]

# Create a list to store new lines
new_lines = []

# Open scorefile
new_file_name= "Totalscores_passed_structures_" + filename
# Open new file and scorefile for reading
with open(new_file_name, "w") as new_file, open(filename, "r") as score_file:
    score_lines=score_file.readlines()[2:]
    # Loop through each line in input.txt
    for line in score_lines:
        # Split line into columns
        columns = line.split()
        # Get total score from column 2
        total_score=columns[1]
    

        # Check if the total score is above the threshhold:
        minus="-"
        if minus in total_score:
            if boundary < total_score:
                nome=columns[len(columns)-1]
                if nome.find("1h38")!=-1:
                    
                    # Replace line with placeholder string
                    new_lines.append(columns[1] + " " + nome)
                elif nome.find("1cez")!=-1:
                    new_lines.append(columns[1] + " " + nome)
            
    new_file.seek(0)
    new_file.write("\n".join(new_lines))
    new_file.truncate()






	
