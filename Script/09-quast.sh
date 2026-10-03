#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_quast_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_quast_%j.e
#SBATCH --partition=pshort_el8

in_flye_dir="/data/users/mmaisyaroh/assembly_course/assemblies/flye"
in_hifiasm_dir="/data/users/mmaisyaroh/assembly_course/assemblies/hifiasm"
in_lja_dir="/data/users/mmaisyaroh/assembly_course/assemblies/LJA"
ref_dir="/data/courses/assembly-annotation-course/references"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/quast"
CONTAINER="/containers/apptainer/quast_5.2.0.sif"
 

REF="${ref_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
ANOT="${ref_dir}/Arabidopsis_thaliana.TAIR10.57.gff3"
 
FLYE="${in_flye_dir}/assembly.fasta"
HIFIASM="${in_hifiasm_dir}/Hiroshima_hifiasm.fa"
LJA="${in_lja_dir}/assembly.fasta"
 
 
mkdir -p "${out_dir}"
cd "${out_dir}"
 
# 1) WITHOUT reference 
apptainer exec --bind /data ${CONTAINER} quast.py ${FLYE} ${HIFIASM} ${LJA} --labels flye,hifiasm,lja --eukaryote --large --est-ref-size 135000000 --threads 16 -o ${out_dir}/no_reference
 
# 2) WITH reference
apptainer exec --bind /data ${CONTAINER} quast.py ${FLYE} ${HIFIASM} ${LJA} --labels flye,hifiasm,lja --eukaryote --large -r ${REF} --features gene:${ANOT} --threads 16 -o ${out_dir}/with_reference


