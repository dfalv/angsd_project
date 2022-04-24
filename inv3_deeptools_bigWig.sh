#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --job-name=inv3_bigWig
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=10G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_bigWig.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_bigWig.txt
echo "Running on node:" `hostname` >> inv3_bigWig.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_bigWig.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_bigWig.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

mamba activate deeptools

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out")
blacklist=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/blacklist/mm10-blacklist.bed.gz")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

bamCoverage --bam ${input_path}/${sample_name}_sorted.bam -o ${output_path}/${sample_name}.SeqDepthNorm.bw \
  -of bigwig --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2639030727 \
  -v --ignoreForNormalization chrX --minFragmentLength 49 -p 8 --ignoreDuplicates

exit
