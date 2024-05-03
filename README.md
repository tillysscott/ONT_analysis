# MinION_processing
MinION sequencing processing  
Scripts needed for Sue's methylation analysis  

## Basecall with Guppy, generate statistics plots with Nanoplot:
1. Call bases from pod5 with Guppy and Nanoplot: guppy_normal.sh
2. Call modified bases from pod 5 with Guppy and Nanoplot: guppy_methylation.sh
INPUTS: pod5 directory  
OUTPUTS: basecall_guppy/pass OR basecall_guppy_5mC/pass directories with *.fastq.gz files  

## Remove contamination from reads with kraken2
1. Download standard kraken2 database or use Tilly's: kraken2_buildDB.sh
2. Find and remove contaminants from reads: kraken2_analysis_reads.sh .  
  a. Generating the list of sequences can be done in the command line, checked and then hashed out of script  
INPUTS: list of basecall_guppy/pass/*.fastq.gz files  
OUTPUTS: *.kraken.report with summary information, and *.unclassified_kraken_out.fq with non-contaminant reads with fastq format, as well as .out file and *.classified_kraken_out.fq  
_also see_ kraken2_analysis_on_sequence.sh for running krarken2_analysis on fasta sequence

## Assemble reads
