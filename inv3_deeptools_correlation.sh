#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=bwCorr
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_deeptools_correlation.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_deeptools_correlation.txt
echo "Running on node:" `hostname` >> inv3_deeptools_correlation.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_deeptools_correlation.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_deeptools_correlation.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

mamba activate deeptools

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out/multiBW_summary")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out/multiBW_correlation/")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

plotCorrelation \
    -in ${input_path}/multiBW_summary_out.npz \
    --corMethod spearman --skipZeros \
    --plotTitle "Spearman Correlation of Read Counts" \
    --whatToPlot heatmap --colorMap RdYlBu --plotNumbers \
    -o ${output_path}/hm_Spearman_inv3_multiBW.svg   \
    --outFileCorMatrix ${output_path}/Spearman_inv3_multiBW.tab

exit
