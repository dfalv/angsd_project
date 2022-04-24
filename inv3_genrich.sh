#! /bin/bash -l

#SBATCH --partition=angsd_class
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=inv3_genrich
#SBATCH --time=48:00:00   # HH/MM/SS
#SBATCH --mem=40G   # memory requested, units available: K,M,G,T

echo "Starting at:" `date` >> inv3_genrich.txt
echo "This is job #:" $SLURM_JOB_ID ${1} >> inv3_genrich.txt
echo "Running on node:" `hostname` >> inv3_genrich.txt
echo "Running on cluster:" $SLURM_CLUSTER_NAME >> inv3_genrich.txt
echo "This job was assigned the temporary (local) directory:" $TMPDIR >> inv3_genrich.txt
touch  ${TMPDIR}/test_file_$SLURM_JOB_ID

mamba activate genrich

sample_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/bwt_out/query_sorted")
output_path=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out")
sample_name=$(echo "${1}" | cut -d"_" -f1,2)
blacklist=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/blacklist/mm10-blacklist.bed.gz")

def_q05_a20_pkOut=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/thr_q05_a20")
q01_a200_pkOut=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/thr_q01_a200")
q25_a200_pkOut=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/thr_q25_a200")
q01_a20_pkOut=$(echo "/athena/angsd/scratch/daf2042/2021_12_01_inv3_12WR_2D-Ras_Chandwani-DF-11596/trimmed/genrich_out/thr_q01_a20")

#default
Genrich  -t ${sample_path}/${sample_name}_QUsorted.bam  -o ${def_q05_a20_pkOut}/${sample_name}_q05_a20.narrowPeak  \
  -f ${output_path}/${sample_name}.log  -b ${output_path}/${sample_name}.bed  -j  -r  -x  -q 0.05  -a 20.0  -v  \
  -e chrM,chrY  -E ${blacklist}

#stringent q & a
Genrich  -P  -f ${output_path}/${sample_name}.log \
  -o ${q01_a200_pkOut}/${sample_name}_q01_a200.narrowPeak  -q 0.01  -a 200  -v

#lenient q
Genrich  -P  -f ${output_path}/${sample_name}.log \
  -o ${q25_a200_pkOut}/${sample_name}_q25_a200.narrowPeak  -q 0.25  -a 200  -v

#lenient a
Genrich  -P  -f ${output_path}/${sample_name}.log \
  -o ${q01_a20_pkOut}/${sample_name}_q01_a20.narrowPeak  -q 0.01  -a 20  -v

  exit
