#! /bin/bash

# this should point to the directory of this VEP atlas repo
vep_atlas_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

# subject name
SUBJECT="sub-tmp" 

# where should results be stored
SUBJECTS_DIR="/Users/pault/Projects/EPINOV/code/VEP_atlas_shared/tmp/" 
export SUBJECTS_DIR

# point this to the T1 image you want to process
T1_image="/Users/pault/Projects/EPINOV/code/VEP_atlas_shared/tmp/T1.RAS.RO.nii.gz"

# set nthread to number of cores you want ot use for parallel processing
nthread=8

# run Freesurfers recon-all pipeline
# recon-all -s ${SUBJECT} -i ${T1_image} -all -parallel -openmp ${nthread}

# loop across right and left hemisphere
for hemi in lh rh
do
    # create cortical VEP parcellation
	python -m convert_to_vep_parc convert_parc 	\
            ${SUBJECTS_DIR}/${SUBJECT}/label/${hemi}.aparc.a2009s.annot \
            ${SUBJECTS_DIR}/${SUBJECT}/surf/${hemi}.pial				   \
            ${SUBJECTS_DIR}/${SUBJECT}/surf/${hemi}.inflated			   \
            ${hemi}												\
            ${vep_atlas_dir}/data/VepAparcColorLut.txt			\
            ${vep_atlas_dir}/data/VepAtlasRules.txt				\
            ${SUBJECTS_DIR}/${SUBJECT}/label/${hemi}.aparc.vep.annot
done

# map cortical labels into the volume
mri_aparc2aseg --s ${SUBJECT} --annot aparc.vep --base-offset 70000 \
                --o ${SUBJECTS_DIR}/${SUBJECT}/mri/aparc+aseg.vep.mgz


# create volumetric subcortical VEP parcellation
python -m convert_to_vep_parc convert_seg      \
        ${SUBJECTS_DIR}/${SUBJECT}/mri/aparc+aseg.vep.mgz \
        ${vep_atlas_dir}/data/VepFreeSurferColorLut.txt   \
        ${vep_atlas_dir}/data/VepAtlasRules.txt           \
        ${SUBJECTS_DIR}/${SUBJECT}/mri/aparc+aseg.vep.mgz