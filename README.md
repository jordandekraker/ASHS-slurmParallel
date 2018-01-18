# ashs
Automatic Segmentation of Hippocampal Subfields, modiefied to work using slurm parallelization.

For original full documentation see [https://sites.google.com/site/hipposubfields/home]

TODO:
 - get ashs_train.sh working (need to split some stages into additional jobs)
 - prevent redundant joblists being created (one in parent directory, one in output directory. only parent directory version appears to contain correct jobs)
 - consider adding the possibility of progagating multiple labels (e.g. multiple laplace gradients)
