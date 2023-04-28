#PBS -l nodes=1:ppn=24
#PBS -l mem=40gb
#PBS -N asmbl
#PBS -l walltime=24:00:00
#PBS -q cgsd
#PBS -e .asmble
#PBS -o .asmblo
###qsub run/epilepsy/run_assemble.sh

cd /groups/cgsd/shengxu/epilepsy/LauG_Metagenomics_CPOS-221215-MHWK-15822a/LauG_Metagenomics_CPOS-221215-MHWK-15822a/

module load megahit
#for sample in `cat $idlist`
for i in $(cat idlist)
do
    megahit -1 clean_data/${i}_clean_1.fastq -2 clean_data/${i}_clean_2.fastq -t 48 -o ~/assemble/$i
done


