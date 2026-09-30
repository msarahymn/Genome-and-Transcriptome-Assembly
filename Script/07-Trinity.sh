#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=trinity
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_trinity_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_trinity_%j.e
#SBATCH --partition=pshort_el8


clean_dir="/data/users/mmaisyaroh/assembly_course/read_QC/fastp"
R1="${clean_dir}/RNAseq_Sha_1.clean.fastq.gz"
R2="${clean_dir}/RNAseq_Sha_2.clean.fastq.gz"

out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/trinity"


mkdir -p "$(dirname "${out_dir}")"
module load Trinity/2.15.1-foss-2021a
 
Trinity \
  --seqType fq \
  --left "${R1}" \
  --right "${R2}" \
  --CPU 16 \
  --max_memory 60G \
  --output "${out_dir}"