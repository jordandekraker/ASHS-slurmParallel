# ashs
Automatic Segmentation of Hippocampal Subfields, modiefied to work using slurm parallelization.

For original full documentation see [https://sites.google.com/site/hipposubfields/home]

TODO:
 - get ashs_train.sh working (need to split some stages into additional jobs)
 - prevent redundant joblists being created (one in parent directory, one in output directory. only parent directory version appears to contain correct jobs)
 - consider adding the possibility of progagating multiple labels (e.g. multiple laplace gradients)
=======
For full documentation see [https://sites.google.com/site/hipposubfields/home]

Dependency:
https://github.com/khanlab/neuroglia-helpers

The current project is designed to work on compute canada's sharcnet server graham (https://www.sharcnet.ca/help/index.php/Graham). Thus it uses Slurm parallelization rather than SGE or GNU (as in the original release).

