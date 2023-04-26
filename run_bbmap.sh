#!/bin/sh

#PBS -l nodes=1:ppn=48
#PBS -l mem=120g
#PBS -l walltime=96:00:00
#PBS -N bb
#PBS -q cgsd 
#PBS -e .bberr
#PBS -o .bbout
###qsub run/epilepsy/run_bbmap.sh

ml miniconda3/4.12.0
module add parallel
# source activate dvf
source activate mypy3


# index contigs
# > map raw reads (before megahit) to contigs -- samtools/ bedtools
# >> match with blast output


# cd /groups/cgsd/shengxu/epilepsy/LauG_Metagenomics_CPOS-221215-MHWK-15822a/LauG_Metagenomics_CPOS-221215-MHWK-15822a/clean_data/

function m_bbmap {
# for i in *
# do
i=$(eval "echo "$1" | cut -d / -f9 |cut -d _ -f1")
bbmap.sh in1=${1}_clean_1.fastq in1=${1}_clean_2.fastq out=mapped.sam ref=assemble/${i}/blast_contigs.fa nodisk
# https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/usage-guide/
# done

}
export -f m_bbmap

parallel -j 4 m_bbmap ::: /groups/cgsd/shengxu/epilepsy/LauG_Metagenomics_CPOS-221215-MHWK-15822a/LauG_Metagenomics_CPOS-221215-MHWK-15822a/clean_data/*

