# ashs
Automatic Segmentation of Hippocampal Subfields, modiefied to work using slurm parallelization.

The current project is designed to work on compute canada's sharcnet server graham (https://www.sharcnet.ca/help/index.php/Graham). Thus it uses Slurm parallelization in addition to the original SGE or GNU.

For original full documentation see [https://sites.google.com/site/hipposubfields/home]

Dependency:
https://github.com/khanlab/neuroglia-helpers

TODO:
 - get ashs_train.sh working (need to split some stages into additional jobs)
 - prevent redundant joblists being created (one in parent directory, one in output directory. only parent directory version appears to contain correct jobs)
 - consider adding the possibility of propagating multiple labels (e.g. multiple laplace gradients)
 
