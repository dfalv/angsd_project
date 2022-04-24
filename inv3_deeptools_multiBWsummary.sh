#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --job-name=bwSmry
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=25G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_multiBW_summary.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_multiBW_summary.txt
echo "Running on node:" `hostname` >> inv3_multiBW_summary.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_multiBW_summary.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_multiBW_summary.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

mamba activate deeptools

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out/multiBW_summary")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

multiBigwigSummary bins -b ${input_path}/1615_mktC.SeqDepthNorm.bw  ${input_path}/1669_mktS.SeqDepthNorm.bw \
  ${input_path}/1731_mktS.SeqDepthNorm.bw ${input_path}/1737_mktC.SeqDepthNorm.bw \
  ${input_path}/1780_mktC.SeqDepthNorm.bw ${input_path}/1665_mktC.SeqDepthNorm.bw \
  ${input_path}/1728_mktC.SeqDepthNorm.bw ${input_path}/1732_mktS.SeqDepthNorm.bw \
  ${input_path}/1751_mktC.SeqDepthNorm.bw -p 8 -o ${output_path}/multiBW_summary_out.npz

exit
