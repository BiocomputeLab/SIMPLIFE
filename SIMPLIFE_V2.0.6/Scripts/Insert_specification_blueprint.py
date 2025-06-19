import shutil

# Open input.txt file
with open("input.txt", "r") as input_file:
    # Loop through each line in input.txt
    for line in input_file:
        # Split line into two columns
        columns = line.strip().split()
        # Get lower and upper bounds from columns
        lower_bound = int(columns[0])
        upper_bound = int(columns[1])
        # Create new file name using lower bound
        new_file_name = "wildtype_" + str(lower_bound) + "_" + str(upper_bound) + ".blueprint"
        # Copy wildtype.blueprint to new file
        shutil.copy("wildtype.blueprint", new_file_name)
        # Open new file and wildtype.blueprint for reading
        with open(new_file_name, "w") as new_file, open("wildtype.blueprint", "r") as wildtype:
            # Create a list to store new lines
            new_lines = []
            # Loop through each line in wildtype.blueprint
            for wildtype_line in wildtype:
                # Split line into first column and rest of line
                wildtype_columns = wildtype_line.strip().split(None, 2)
                # Check if first column is an integer
                if wildtype_columns[0].isdigit():
                    # Convert first column to int
                    wildtype_int = int(wildtype_columns[0])
                    # Check if first column is between lower and upper bounds
                    if lower_bound <= wildtype_int < upper_bound:
                        # Replace line with placeholder string
                        new_lines.append("*************" + wildtype_columns[1] + wildtype_columns[2])
                    else:
                        # Keep line as is
                        new_lines.append(wildtype_line)
                else:
                    # Keep line as is
                    new_lines.append(wildtype_line)
            # Write new lines to new file
            new_file.seek(0)
            new_file.write("".join(new_lines))
            new_file.truncate()
            
        #search through newly created file and replace *** with peptide insertion
            pattern="*************"
            result_name = "Input_" + str(lower_bound) + "_" + str(upper_bound) + ".blueprint"
            with open(new_file_name, "r") as file, open(result_name, "w") as result:
                
                for line in file:
                    line=line.strip('\r\n')
                    line_columns = line.strip().split(None, 2)
                    
                    if pattern in line:
                        line = "0 x L\n0 x L\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x I NATRO\n0 x L\n0 x L"
                    
                    if line_columns[0].isdigit():
                        # Convert first column to int
                        line_int = int(line_columns[0])
                        # Check if first column is between lower and upper bounds
                        if  line_int == lower_bound-1:
                            line = line_columns[0] + " " + line_columns[1] + " " + "L PIKAA " + line_columns[1]
                        
                        if  line_int == upper_bound+1:
                            line = line_columns[0] + " " + line_columns[1] + " " + "L PIKAA " + line_columns[1]
            
                    result.write(line + '\n')

                result.close()
                
                
        
          
            


