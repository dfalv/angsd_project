#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_bedSort
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=10G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_bedSort.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_bedSort.txt
echo "Running on node:" `hostname` >> inv3_bedSort.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_bedSort.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_bedSort.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/bed_unsorted")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/bed_sorted")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

sort -k1,1 -k2,2n ${input_path}/${sample_name}.bed > ${output_path}/${sample_name}_chrSorted.bed

exit
