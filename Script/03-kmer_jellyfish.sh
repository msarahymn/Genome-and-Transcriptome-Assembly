#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=02:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_jellyfish_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_jellyfish_%j.e
#SBATCH --partition=pshort_el8

IN_DIR="/data/users/mmaisyaroh/assembly_course/read_QC/Hiroshima/ERR11437318.fastq.gz"
OUT_DIR="/data/users/mmaisyaroh/assembly_course/read_QC/kmer_counting"
CONTAINER="/containers/apptainer/jellyfish:2.2.6--0"

mkdir -p "${OUT_DIR}"

# Count 21-mers
apptainer exec --bind /data "${CONTAINER}" \
  jellyfish count \
  -C -m 21 -s 5G -t 4 \
  -o "${OUT_DIR}/Hiroshima_reads.jf" \
  <(zcat "${IN_DIR}")

#Make the histogram
apptainer exec --bind /data "${CONTAINER}" \
  jellyfish histo \
  -t 4 \
  "${OUT_DIR}/Hiroshima_reads.jf" \
  > "${OUT_DIR}/Hiroshima_reads.histo"

