#!/bin/bash
#SBATCH --job-name=bbmap
#SBATCH --mail-type=ALL
#SBATCH --mail-user=djlemas@ufl.edu
#SBATCH --ntasks=2
#SBATCH --mem=40gb
#SBATCH --account=djlemas
#SBATCH --qos=djlemas-b
#SBATCH --time=0:20:00
#SBATCH --output=bbmap_%j.log
pwd; hostname; date

# load modules
module load bbmap

# Download and uncompress files
# wget https://zenodo.org/record/1068229/files/YAMP_resources_20171128.tar.gz
tar -xzf /ufrc/djlemas/djlemas/DEMO-YAMP/YAMP/YAMP_resources_20171128.tar.gz

#Run nextflow script
bbmap.sh -Xmx40G ref=hg19_main_mask_ribo_animal_allplant_allfungus.fa.gz
rm YAMP_resources_20171128.tar.gz
date