#!/bin/bash
#SBATCH --job-name=YAMPjob_%j
#SBATCH --mail-type=NONE
#SBATCH --mail-user=xinsongdu@ufl.edu
#SBATCH --ntasks=4
#SBATCH --mem=40gb
#SBATCH --account=djlemas
#SBATCH --qos=djlemas-b
#SBATCH --time=2:00:00
#SBATCH --output=logs/YAMPjob_%j.log
pwd; hostname; date

# load modules
module load bbmap
module load singularity
module load nextflow
module load fastqc         
module load bbmap          
module load samtools       
# module load metaphlan2     
module load qiime          
module load python/2.7.14 
module load java/9.0.1

#Run nextflow script
nextflow run YAMP.nf --reads1 $1 --reads2 $2 --prefix $3 --outdir results --mode complete -with-singularity docker://dominicklemas/ufrc-yamp
date
