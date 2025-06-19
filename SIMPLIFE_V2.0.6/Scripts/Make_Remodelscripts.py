import shutil

# Loop through to create 9 new scripts for each bin to run in parallel


for i in range(1,10):
    # Create new file name using lower bound
    name=str(i)
    new_file_name = "Remodel_bin" + name + ".sh"
    # Copy to new file
    shutil.copy("Remodel_binX.sh", new_file_name)


    # Open new file for reading
    
    with open(new_file_name, 'r') as file:
        filedata = file.read()

    #Replace the binX with bin number 

    binnum="bin" + name
    filedata = filedata.replace('binX',binnum)
    
    with open(new_file_name, 'w') as file:
        file.write(filedata)

                
        
          
            


