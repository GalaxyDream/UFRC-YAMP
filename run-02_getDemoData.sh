#!/bin/bash
#SBATCH --job-name=demo_%j
#SBATCH --mail-type=NONE
#SBATCH --mail-user=djlemas@ufl.edu
#SBATCH --ntasks=1
#SBATCH --mem=5gb
#SBATCH --account=djlemas
#SBATCH --qos=djlemas-b
#SBATCH --time=10:00:00
#SBATCH --output=demo_%j.log
pwd; hostname; date

mkdir data/
cd ./data
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR011/ERR011089/ERR011089_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR011/ERR011089/ERR011089_2.fastq.gz