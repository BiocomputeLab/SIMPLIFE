###Pythonscript for phylogenetic trees of 
import os

import sys
from Bio.Align.Applications import ClustalwCommandline


fastafile=sys.argv[1]


name=fastafile.split(".", )
name=name[0]


print(name)

cline = ClustalwCommandline("clustalw2", infile=fastafile)

stdout, stderr = cline()


from Bio import AlignIO

alignmentname=name + ".aln"

with open(alignmentname, "r") as aln:
    alignment = AlignIO.read(aln,"clustal")

from Bio import Phylo
from Bio.Phylo.TreeConstruction import DistanceCalculator

calculator = DistanceCalculator('blosum62')
dm = calculator.get_distance(alignment)


from Bio.Phylo.TreeConstruction import DistanceTreeConstructor
constructor = DistanceTreeConstructor(calculator)

phylotree = constructor.build_tree(alignment)
#print(phylotree)

from Bio.Phylo.BaseTree import TreeMixin

nodes=phylotree.count_terminals()
print(nodes)

if nodes <= 10:
    fontsize=8
elif 10 < nodes <= 25:
    fontsize=6
else:
    fontsize=4


import matplotlib
import matplotlib.pyplot as plt

plt.ioff()

fig = plt.figure(figsize=(13, 5), dpi=1000) # create figure & set the size
matplotlib.rc('font', size=fontsize)             # fontsize of the leaf and node labels
matplotlib.rc('xtick', labelsize=10)       # fontsize of the tick labels
matplotlib.rc('ytick', labelsize=10)       # fontsize of the tick labels
#turtle_tree.ladderize()           # optional way to reformat your tree
axes = fig.add_subplot(1, 1, 1)



Phylo.draw(phylotree, axes=axes, do_show=0)

figurename= name + "_cladogram"
fig.savefig(figurename)
plt.close(fig)






