#!/bin/bash

#SBATCH --time=36:00:00
#SBATCH -c 20
#SBATCH --mem 100G
#SBATCH --partition=uoa-compute

export genome="Platorchestia_hallaensis"

# round 4: rename outputs
rename known_mask.masked.fa unknown_mask 04_unknown_out/${genome}*
rename .masked .masked.fa 04_unknown_out/${genome}*
echo Outputs from unknown masking round renamed

# create directory for full results
mkdir -p 05_full_out
echo Directory 05_full_out made

#gzip .cat files as these are large
gzip 01_simple_out/${genome}.simple_mask.cat
gzip 02_arthropoda_out/${genome}.arthropoda_mask.cat
gzip 03_known_out/${genome}.known_mask.cat
gzip 04_unknown_out/${genome}.unknown_mask.cat
echo mask.cat files gzipped

# combine full RepeatMasker result files - .cat.gz
cat 01_simple_out/${genome}.simple_mask.cat.gz \
02_arthropoda_out/${genome}.arthropoda_mask.cat.gz \
03_known_out/${genome}.known_mask.cat.gz \
04_unknown_out/${genome}.unknown_mask.cat.gz \
> 05_full_out/${genome}.full_mask.cat.gz
echo .cat.gz outputs concatenated to generate full_mask.cat.gz and added to 05_full_out

# combine RepeatMasker tabular files for all repeats - .out
cat 01_simple_out/${genome}.simple_mask.out \
<(cat 02_arthropoda_out/${genome}.arthropoda_mask.out | tail -n +4) \
<(cat 03_known_out/${genome}.known_mask.out | tail -n +4) \
<(cat 04_unknown_out/${genome}.unknown_mask.out | tail -n +4) \
> 05_full_out/${genome}.full_mask.out
echo tabular files combined and added to 05_full_out

# copy RepeatMasker tabular files for simple repeats - .out
cat 01_simple_out/${genome}.simple_mask.out > 05_full_out/${genome}.simple_mask.out
echo simple repeats mask added to 05_full_out directory

# combine RepeatMasker tabular files for complex, interspersed repeats - .out
cat 02_arthropoda_out/${genome}.arthropoda_mask.out \
<(cat 03_known_out/${genome}.known_mask.out | tail -n +4) \
<(cat 04_unknown_out/${genome}.unknown_mask.out | tail -n +4) \
> 05_full_out/${genome}.complex_mask.out
echo .out file combined and added to 05_full_out

# combine RepeatMasker repeat alignments for all repeats - .align
cat 01_simple_out/${genome}.simple_mask.align \
02_arthropoda_out/${genome}.arthropoda_mask.align \
03_known_out/${genome}.known_mask.align \
04_unknown_out/${genome}.unknown_mask.align \
> 05_full_out/${genome}.full_mask.align
echo .align files combined and added to 05_full_out
