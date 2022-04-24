#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_tss
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=4G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_tss.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_tss.txt
echo "Running on node:" `hostname` >> inv3_tss.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_tss.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_tss.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

mamba activate deeptools

input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/deeptools_out/tss_plot")
knownGenes=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/mm10_knownGenes.bed")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)

computeMatrix reference-point \
  -S ${input_path}/${sample_name}.SeqDepthNorm.bw -R ${knownGenes} \
  --referencePoint TSS \
  -a 2000 -b 2000 \
  -out ${output_path}/inv3_${sample_name}_TSS.tab.gz

plotHeatmap -m ${output_path}/inv3_${sample_name}_TSS.tab.gz \
  -out ${output_path}/${sample_name}_hm_ATAC.svg \
  --heatmapHeight 15 \
  --refPointLabel center

  exit
