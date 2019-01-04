#!/bin/bash
#SBATCH --job-name=bbmap
#SBATCH --mail-type=ALL
#SBATCH --mail-user=djlemas@ufl.edu
#SBATCH --ntasks=2
#SBATCH --mem=20gb
#SBATCH --time=1:00:00
#SBATCH --output=bbmap_%j.log
pwd; hostname; date

# load modules
module load bbmap

#Run nextflow script
cd /ufrc/djlemas/djlemas/YAMP/resources 
bbmap.sh -Xmx20G ref=hg19_main_mask_ribo_animal_allplant_allfungus.fa.gz

date