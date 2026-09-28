#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_hifiasm_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

in_dir="/data/users/mmaisyaroh/assembly_course/read_QC/Hiroshima/ERR11437318.fastq.gz"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/hifiasm"
CONTAINER="/containers/apptainer/hifiasm_0.25.0.sif"
 
mkdir -p "${out_dir}"

apptainer exec --bind /data "${CONTAINER}" \
  hifiasm \
  -o "${out_dir}/Hiroshima" \
  -t 16 \
  "${in_dir}"

#Convert GFA format to Fasta format
awk '/^S/{print ">"$2;print $3}' "${out_dir}/Hiroshima.bp.p_ctg.gfa" \
  > "${out_dir}/Hiroshima_hifiasm.fa"