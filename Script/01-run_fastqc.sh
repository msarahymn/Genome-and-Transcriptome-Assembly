#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=02:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/output_fastqc_%j.o
#SBATCH --error=/data/users/mmaisyaroh/error_fastqc_%j.e
#SBATCH --partition=pshort_el8

WORKDIR="/data/users/mmaisyaroh/assembly_course/read_QC"
OUTDIR="${WORKDIR}/fastqc"

mkdir -p "${OUTDIR}"
cd "${WORKDIR}"

apptainer exec \
--bind /data \
/containers/apptainer/fastqc-0.12.1.sif \
fastqc \
--outdir "${OUTDIR}" \
  --threads 4 \
  Hiroshima/*.fastq.gz

apptainer exec \
  --bind /data \
  /containers/apptainer/fastqc-0.12.1.sif \
  fastqc \
  --outdir "${OUTDIR}" \
  --threads 4 \
  RNAseq_Sha/*.fastq.gz