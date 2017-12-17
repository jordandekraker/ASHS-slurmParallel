#!/bin/bash
#$ -S /bin/bash

#######################################################################
#
#  Program:   ASHS (Automatic Segmentation of Hippocampal Subfields)
#  Module:    $Id$
#  Language:  BASH Shell Script
#  Copyright (c) 2012 Paul A. Yushkevich, University of Pennsylvania
#  
#  This file is part of ASHS
#
#  ASHS is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details. 
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#######################################################################

set -x -e

# Read the parameters
id=${1?}

# Include the common file
source ${ASHS_ROOT?}/bin/ashs_lib.sh

# Verify all the necessary inputs
cat <<-BLOCK1
	Script: ashs_atlas_resample_to_template.sh
	Root: ${ASHS_ROOT?}
	Working directory: ${ASHS_WORK?}
	PATH: ${PATH?}
  Id: ${id?}
BLOCK1

# Go to my directory
pushd $ASHS_WORK/atlas/$id

# Copy the warps from the template building directory to the atlas directory
mkdir -p ants_t1_to_temp
for what in Warp.nii.gz InverseWarp.nii.gz Affine.txt; do
  cp -av $ASHS_WORK/template_build/atlas${id}_mprage${what} ants_t1_to_temp/ants_t1_to_temp${what}
done

# Histogram match the images to a reference image (used later down the road, but better to do it now)
# If the number of control points is 0, we don't do histogram matching. Instead, we link the histmatch
# file to the original file
if [[ $ASHS_SKIP && \
      -f tse_histmatch.nii.gz && \
      -f mprage_histmatch.nii.gz ]]
then 
  echo "Skipping histogram matching"
else
  if [[ ${ASHS_HISTMATCH_CONTROLS} -gt 0 ]]; then
    c3d $ASHS_WORK/final/ref_hm/ref_tse.nii.gz tse.nii.gz \
      -histmatch ${ASHS_HISTMATCH_CONTROLS} -o tse_histmatch.nii.gz

    c3d $ASHS_WORK/final/ref_hm/ref_mprage.nii.gz mprage.nii.gz \
      -histmatch ${ASHS_HISTMATCH_CONTROLS} -o mprage_histmatch.nii.gz
  else
    ln -sf tse.nii.gz tse_histmatch.nii.gz
    ln -sf mprage.nii.gz mprage_histmatch.nii.gz
  fi
fi

# Reslice the atlas to the template
ashs_reslice_to_template . $ASHS_WORK/final

# If heuristics specified, create exclusion maps for the labels
if [[ $ASHS_HEURISTICS ]]; then

  for side in $SIDES; do

    mkdir -p heurex
    subfield_slice_rules tse_native_chunk_${side}_seg.nii.gz $ASHS_HEURISTICS heurex/heurex_${side}_%04d.nii.gz

  done
fi


popd
