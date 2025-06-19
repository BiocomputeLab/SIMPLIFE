import shutil
import sys


Startnumber_from_shell=sys.argv[1]
Endnumber_from_shell=sys.argv[2]

startseq=int(Startnumber_from_shell)-1
insertstart=startseq+6
insertend=startseq+25

endseq=startseq+31

Res_file = "resfile_" + Startnumber_from_shell + "_" + Endnumber_from_shell + ".res"
with open(Res_file, "w") as resfile:
    #Specify the natro header for the file
    natro="NATRO \nstart"
    resfile.write(natro + '\n')
    
    for i in range (startseq, insertstart):
        line = str(i) + " A" + " ALLAA" + " EX 1" + " EX 2"
        resfile.write(line + '\n')
    
    for j in range (insertstart, insertend):
        line = str(j) + " A" + " NATAA" + " EX 1" + " EX 2"
        resfile.write(line + '\n')
    
    for k in range (insertend, endseq):
        line = str(k) + " A" + " ALLAA" + " EX 1" + " EX 2"
        resfile.write(line + '\n')
    
    resfile.close()
    
