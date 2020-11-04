# Virtual epileptic patient atlas 

This repository contains the code to reconstruct the virtual epileptic patient (VEP) atlas on a given subjects T1 image. 
The T1 image is processed with Freesufers recon-all pipeline. 
Subsequently the cortical Destrieux parcellation and subcortical segmentation are modified accordingly to generate the subject specific VEP parcellation.
An overview of the atlas and the labelling can be found in 
./doc_files/VEP atlas for Guidance.docx

## Dependencies
* Freesurfer 
	* Download available here https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
* Python with numpy, nibabel and sklearn 
	* If you have conda installed you can use the following command with the provided environment.yml to create a new python environment with the necessary packages.
	* conda env create -f environment.yml
	


## Run 

In order to create the VEP parcellation please first insert the correct variables at the top of the script "create_vep_parc.sh", i.e. set the directory where to store results, subject name, number of cores to use in parallel etc.

Afterwards you can execute the script with 
sh create_vep_parc.sh

The recon-all pipeline can take several hours (6-12h), depending on how many cores you can use to parallelize the computation. 
Subsequently the python script "convert_to_vep_parc.py" is called. 
It uses the look up tables and modification rules inside the ./data/ directory to create the VEP atlas. 

The results are stored in Freesurfers file format.
The cortical annotation file can be found here :
${SUBJECTS_DIR}/${SUBJECT}/label/${hemi}.aparc.vep.annot

The volumentric parcellation/segmentation can be found here :
${SUBJECTS_DIR}/${SUBJECT}/mri/aparc+aseg.vep.mgz

## Citation
Huifang E. Wang, Julia Scholly, Paul Triebkorn, Viktor Sip, Samuel MedinaVillalon, Marmaduke M. Woodman, Arnaud Le Troter, Maxime Guye, Fab-rice Bartolomei, and Viktor Jirsa.  VEP atlas:  An anatomic and functionalhuman brain atlas dedicated to epilepsy patients.Journal of NeuroscienceMethods, page 108983, oct 2020.
https://doi.org/10.1016/j.jneumeth.2020.108983
