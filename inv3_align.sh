#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --job-name=inv3_align
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=20G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_align.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_align.txt
echo "Running on node:" `hostname` >> inv3_align.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_align.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_align.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load bowtie2@2.3.5.1%gcc@6.3.0
spack load samtools@1.9%gcc@6.3.0

indx_foldr_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/bwt_index")
samp_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed")
tmp_path=$(echo "/scratchLocal/daf2042")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

mkdir -p ${tmp_path}

#${1} specifies an argument
bowtie2 --threads 12 -x ${indx_foldr_path}/mm10 -q \
  -1 ${samp_path}/${1}_R1_001_val_1.fq.gz \
  -2 ${samp_path}/${1}_R2_001_val_2.fq.gz | \
  samtools sort -m 1G -@ 4 -O bam -T ${tmp_path}/${sample_name}.tmp - > ${output_path}/${sample_name}_sorted.bam

exit
