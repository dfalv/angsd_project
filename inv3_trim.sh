#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --job-name=trimmed
#SBATCH --time=05:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> trimmed.txt
echo "This is job #:" $SLURM_JOB_ID >> trimmed.txt
echo "Running on node:" `hostname` >> trimmed.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> trimmed.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> trimmed.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load -r trimgalore@0.4.5

samp_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/")

#trim_galore --stringency 10 --nextera -o ${output_path} --paired ${samp_path}/subset_1615.fastq.gz ${samp_path}/subset_1615_2.fastq.gz
trim_galore --stringency 10 --nextera -o ${output_path} --paired ${samp_path}/${1}_R1_001.fastq.gz ${samp_path}/${1}_R2_001.fastq.gz

exit
