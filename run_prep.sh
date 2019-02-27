#!/bin/bash
#SBATCH --job-name=bbmap_60min
#SBATCH --mail-type=NONE #Changed ALL to NONE
#SBATCH --mail-user=djlemas@ufl.edu
#SBATCH --ntasks=2
#SBATCH --mem=20gb
#SBATCH --account=djlemas
#SBATCH --qos=djlemas-b
#SBATCH --time=10:00:00
#SBATCH --output=bbmap_60min_%j.log
pwd; hostname; date

# load modules
module load bbmap

# Download and uncompress files
wget https://zenodo.org/record/1068229/files/YAMP_resources_20171128.tar.gz
# Use relative location
tar -xzf YAMP_resources_20171128.tar.gz

# Run nextflow script
cd resources # Change to relative location
bbmap.sh -Xmx40G ref=hg19_main_mask_ribo_animal_allplant_allfungus.fa.gz
rm YAMP_resources_20171128.tar.gz
date
