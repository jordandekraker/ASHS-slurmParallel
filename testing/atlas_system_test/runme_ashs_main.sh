#!/bin/bash
echo "ASHS_ROOT:   ${ASHS_ROOT?}"
echo "Output Dir:  ${1?}"

OUTDIR=${1?}

$ASHS_ROOT/bin/ashs_main.sh \
  -a ~/projects/rrg-akhanf/akhanf/opt/ashs-fastashs/ashs_atlas_penntle_hippo_20170915/ \
  -g images/sub01_mprage.nii.gz \
  -f images/sub01_tse.nii.gz \
  -w $OUTDIR \
  -G \

