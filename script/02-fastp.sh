#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_fastp_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_fastp_%j.e
#SBATCH --partition=pshort_el8

in_dir="/data/users/mmaisyaroh/assembly_course/read_QC"
out_dir="/data/users/mmaisyaroh/assembly_course/read_QC/fastp"
mkdir -p "${out_dir}"

R1=$(ls "${in_dir}"/RNAseq_Sha/*_1.fastq.gz)
R2=$(ls "${in_dir}"/RNAseq_Sha/*_2.fastq.gz)

# 1. Illumina RNA-seq (paired-end)
fastp \
  -i "${R1}" \
  -I "${R2}" \
  -o "${out_dir}/RNAseq_Sha_1.clean.fastq.gz" \
  -O "${out_dir}/RNAseq_Sha_2.clean.fastq.gz" \
  --detect_adapter_for_pe \
  --thread 4 \
  -h "${out_dir}/RNAseq_Sha_fastp.html" \
  -j "${out_dir}/RNAseq_Sha_fastp.json"


#2. PacBio HiFi:
fastp \
  -i "${in_dir}"/Hiroshima/*.fastq.gz \
  -A -Q -L -G \
  --thread 4 \
  -h "${out_dir}/Hiroshima_fastp.html" \
  -j "${out_dir}/Hiroshima_fastp.json"