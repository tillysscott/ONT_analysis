#!/bin/bash

#SBATCH --time=48:00:00
#SBATCH -c 24
#SBATCH --mem 150G
#SBATCH --partition=uoa-compute

#module load kraken2
### Version kraken2/2.1.1 contains a bug in build database step (see slurm-1527761.out and https://github.com/DerrickWood/kraken2/issues/2)

#I have conda installed version 2.1.3
# conda activate kraken2.1.3
#remove this once successfully got database and run kraken2 with module load kraken2
# conda deactivate
# conda remove --name ENVIRONMENT --all

export DBNAME="DB_standard_kraken2"

kraken2-build --standard --threads 24 --db $DBNAME
