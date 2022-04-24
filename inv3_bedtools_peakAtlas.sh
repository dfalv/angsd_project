#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_peakAtlas
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=20G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_peakAtlas.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_peakAtlas.txt
echo "Running on node:" `hostname` >> inv3_peakAtlas.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_peakAtlas.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_peakAtlas.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load bedtools2@2.28.0

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/bed_sorted")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/inv3_peak_atlas")

bedtools intersect -a ${input_path}/1669_mktS_chrSorted.bed -b \
  ${input_path}/1731_mktS_chrSorted.bed ${input_path}/1732_mktS_chrSorted.bed \
  -sorted -wa -wb > ${output_path}/inv3_mktS_peakAtlas.bed

bedtools intersect -a ${input_path}/1615_mktC_chrSorted.bed -b \
  ${input_path}/1665_mktC_chrSorted.bed ${input_path}/1728_mktC_chrSorted.bed ${input_path}/1737_mktC_chrSorted.bed \
  ${input_path}/1737_mktC_chrSorted.bed ${input_path}/1751_mktC_chrSorted.bed ${input_path}/1780_mktC_chrSorted.bed \
  -sorted -wa -wb > ${output_path}/inv3_mktC_peakAtlas.bed

exit
