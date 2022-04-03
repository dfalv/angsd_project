#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_fastqc
#SBATCH --time=24:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_fastqc.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_fastqc.txt
echo "Running on node:" `hostname` >> inv3_fastqc.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_fastqc.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_fastqc.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load fastqc

#untrimmed
untrim_samp=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596")
untrim_out_dir=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/untrim/fastqc")

fastqc -o ${untrim_out_dir} ${untrim_samp}/${1}_R1_001.fastq.gz ${untrim_samp}/${1}_R2_001.fastq.gz

#trimmed
trim_samp=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed")
trim_out_dir=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/fastqc")

fastqc -o ${trim_out_dir} ${trim_samp}/${1}_R1_001_val_1.fq.gz ${trim_samp}/${1}_R2_001_val_2.fq.gz

exit
