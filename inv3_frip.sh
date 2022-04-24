#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=frip
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_frip.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_frip.txt
echo "Running on node:" `hostname` >> inv3_frip.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_frip.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_frip.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load samtools@1.9%gcc@6.3.0
spack load bedtools2@2.28.0%gcc@6.3.0

srt_bam_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out")
genrich_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/FRiP/")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

# total reads
total_reads=$(samtools view -c ${srt_bam_path}/${sample_name}_sorted.bam)

# reads in peaks for Genrich default parameters
reads_in_peaks=$(bedtools sort -i ${genrich_path}/${sample_name}_q05_a20.narrowPeak | \
  bedtools merge -i stdin | bedtools intersect -u -nonamecheck \
  -a ${srt_bam_path}/${sample_name}_sorted.bam -b stdin -ubam | samtools view -c)

# FRiP score
FRiP=$(awk "BEGIN {print "${reads_in_peaks}"/"${total_reads}"}")

echo "${sample_name} FRiP score = ${FRiP}" >> /inv3_fripScores.txt
