#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_mtContent
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_mtContent.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_mtContent.txt
echo "Running on node:" `hostname` >> inv3_mtContent.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_mtContent.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_mtContent.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load samtools@1.9%gcc@6.3.0

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/idxstat")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

mtReads=$(grep 'chrM' ${input_path}/idxstat_${sample_name}.txt | cut -f 3)
totalReads=$(awk '{SUM += $3} END {print SUM}' ${input_path}/idxstat_${sample_name}.txt)
percentMt=$(( 100*${mtReads}/${totalReads} ))

echo '==> ${sample_name} mtDNA Content: ${percentMt}%' >> ${input_path}/inv3_mtConent.txt

exit
