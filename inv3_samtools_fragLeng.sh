#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_fragLeng
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_fragLeng.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_fragLeng.txt
echo "Running on node:" `hostname` >> inv3_fragLeng.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_fragLeng.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_fragLeng.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load samtools@1.9%gcc@6.3.0

sample_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/fragLeng/")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

samtools view ${sample_path}/${sample_name}_sorted.bam | \
  awk '$9>0' | \
  cut -f 9 | \
  sort | uniq -c | \
  sort -b -k2,2n | \
  sed -e 's/^[ \t]*//' > ${output_path}/${sample_name}_fragLength.txt

exit