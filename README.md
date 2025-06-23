# SIMPLIFE
This is SIMPLIFE, a computational workflow for optimising loop design for insertions of small functional peptide tags into globular proteins


## Prerequisites
SIMPLIFE is currently only available for MacOS 

To run SIMPLIFE you are required to have a working version of Rosetta installed and compiled. Compiling Rosetta requires a C++ compiler such as GCC or Clang. 
For more detailed information on how to install Rosetta, please refer to the following [Rosetta tutorial](https://docs.rosettacommons.org/demos/latest/tutorials/install_build/install_build) 


## Preparing input for SIMPLIFE
All input files are to be put in the /input directory when using SIMPLIFE. 

The following two files should be preexisting in the /input directory as part of the default SIMPLIFE distribution: 
- A template “blueprint” file to construct specific blueprint files for each insertions SIMPLIFE attempts to make using Rosetta Remodel
- A model parameter file to allow for adjustment of model parameters such as nstruct.  


The following input files are required to be provided by the user: 
- A file specifying a start and end residue (given as a number) between which the peptides will be replaced by the insertion of a peptide tag  
- A structure file in PDB format of the peptide sequence to be inserted. To be put inside the /input/insert subdirectory
- One or more structure files in PDB format of different conformations of the protein to make insertions into. These PDB files will need to be put inside the /input/backbone subdirectory.   


For each of the provided PDB files provided, the following requirements should be met

- The input files need to be continuous, which no stretches of missing residues in the middle of protein structures 
- The input files needs to have water and similar small atoms removed. You can use the script found as part of the Rosetta download at: tools/protein_tools/scripts/clean_pdb.py to do this 
- The input files needs to be relaxed: This can be achieved through running the Relax_for_input.sh script in the /misc folder to achieve this

## Using SIMPLIFE
Use bash to run the SIMPLIFE_vX.X.X.sh script from the main directory in your terminal to start the grafting/refinement module of SIMPLIFE. You will be prompted to provide a name for your run, as well as provide the path for your compiled version of Rosetta.


