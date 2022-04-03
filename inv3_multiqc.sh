#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_multiqc
#SBATCH --time=08:00:00   # HH/MM/SS
#SBATCH --mem=12G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_multiqc.txt
echo "This is job #:" $SLURM_JOB_ID >> inv3_multiqc.txt
echo "Running on node:" `hostname` >> inv3_multiqc.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_multiqc.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_multiqc.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

spack load -r py-multiqc

#untrimmed multiqc
#input_path=$(echo "/path/to/untim/fastqc")
#output_path=$(echo "/path/to/untim/multiqc/folder")

#trimmed multiqc
input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/inv3_postTrim_multiqc/v3/")

#test
#input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/bwt_log/")
#output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/inv3_postTrim_multiqc/test/")

#bamqc multiqc
#input_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/inv3_bamqc/")
#output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/inv3_postAlign_multiqc/")

multiqc $input_path --outdir $output_path

exit
