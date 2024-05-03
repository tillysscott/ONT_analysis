#!/bin/bash

#SBATCH -c 8 --mem 96G
#SBATCH -p uoa-gpu --gres gpu:1

##########################################################
# arguments:
# 1) input directory with MinION run to basecall
# 2) output directory
#
# example usage:        sbatch guppy.sh minION_flowcell1 guppy_flowcell1
#
# - runs GUPPY (high-accuracy basecalling)
# - tidies GUPPY output files
# - runs NanoPlot
##########################################################

indir=./pod5
outdir=./basecall_guppy

#
# GUPPY
#
# to chose sonfiguration mode (-c) run ## NB already done :. Sue can ignore
## srun -p uoa-gpu guppy_basecaller --print_workflows
#and find kit and flow cell combination
#alternatively replace -c dna.cfg with --flowcell FLO-MIN114 --kit SQK-LSK114
#
#


module load guppy/6.5.7
guppy_basecaller -x "cuda:all" -c dna_r10.4.1_e8.2_400bps_5khz_hac.cfg \
                -i $indir -r -s $outdir --compress_fastq -q 0 --trim_strategy dna --trim_adapters --trim_primers \
                --num_callers 8 --gpu_runners_per_device 8 --chunks_per_runner 768 --chunk_size 500

# compress sequencing summary to save space
gzip $outdir/sequencing_summary.txt

#
# NANOPLOT
## generate summary statistics and plots about sequencing run
#
module load nanoplot
NanoPlot -t 8 --summary $outdir/sequencing_summary.txt.gz -o $outdir/nanoplot
