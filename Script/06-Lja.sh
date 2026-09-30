#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=LJA
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_LJA_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_LJA_%j.e
#SBATCH --partition=pibu_el8

in_dir="/data/users/mmaisyaroh/assembly_course/read_QC/Hiroshima/ERR11437318.fastq.gz"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/LJA"
CONTAINER="/containers/apptainer/lja-0.2.sif"
 
mkdir -p "${out_dir}"

 
apptainer exec --bind /data "${CONTAINER}" \
  lja \
  --reads "${in_dir}" \
  -o "${out_dir}" \
  -t 16