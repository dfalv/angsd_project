#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --job-name=inv3_bamqc
#SBATCH --time=24:00:00   # HH/MM/SS
#SBATCH --mem=8G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_bamqc.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_bamqc.txt
echo "Running on node:" `hostname` >> inv3_bamqc.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_bamqc.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_bamqc.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

bamqc_pkg=$(echo "/softlib/apps/EL7/BamQC/bin/bamqc")
bam_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/")
bamqc_dir=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/inv3_bamqc/")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

$bamqc_pkg $bam_path/${sample_name}_sorted.bam -o $bamqc_dir

exit
