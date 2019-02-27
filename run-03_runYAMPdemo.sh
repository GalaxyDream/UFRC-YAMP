#!/bin/bash
#SBATCH --job-name=demo_%j
#SBATCH --mail-type=NONE
#SBATCH --mail-user=djlemas@ufl.edu
#SBATCH --ntasks=4
#SBATCH --mem=40gb
#SBATCH --account=djlemas
#SBATCH --qos=djlemas-b
#SBATCH --time=10:00:00
#SBATCH --output=demo_%j.log
pwd; hostname; date

# load modules
module load bbmap
module load singularity
module load nextflow
module load fastqc         
module load samtools    
module load qiime          
module load python3
module load java/9.0.1

#Run nextflow script
nextflow run YAMP.nf --reads1 ./data/ERR011089_1.fastq.gz --reads2 ./data/ERR011089_2.fastq.gz --prefix ERR011089 --outdir ./results --mode complete -with-singularity docker://dominicklemas/ufrc-yamp &&
python3 get_stats.py
date
