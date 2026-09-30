#!/usr/bin/env bash
 
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=nucmer
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_NUCMER_ref_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_NUCMER_ref_%j.e
#SBATCH --partition=pshort_el8
 
# Compare each assembly (flye, hifiasm, LJA) against the A. thaliana reference
# nucmer -> delta-filter -1 -> mummerplot
 
in_flye_dir="/data/users/mmaisyaroh/assembly_course/assemblies/flye"
in_hifiasm_dir="/data/users/mmaisyaroh/assembly_course/assemblies/hifiasm"
in_lja_dir="/data/users/mmaisyaroh/assembly_course/assemblies/LJA"
ref_dir="/data/courses/assembly-annotation-course/references"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/nucmer"
CONTAINER="/containers/apptainer/mummer4_gnuplot.sif"
 
REF="${ref_dir}/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
FLYE="${in_flye_dir}/assembly.fasta"
HIFIASM="${in_hifiasm_dir}/Hiroshima_hifiasm.fa"
LJA="${in_lja_dir}/assembly.fasta"
 
 
mkdir -p "${out_dir}"
cd "${out_dir}"
 
# flye vs reference
apptainer exec --bind /data ${CONTAINER} nucmer --prefix flye_vs_ref --breaklen 1000 --mincluster 1000 --threads 16 ${REF} ${FLYE}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/flye_vs_ref.delta > ${out_dir}/flye_vs_ref.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${REF} -Q ${FLYE} --filter -t png --large --layout --fat -p flye_vs_ref flye_vs_ref.filtered.delta
 
# hifiasm vs reference
apptainer exec --bind /data ${CONTAINER} nucmer --prefix hifiasm_vs_ref --breaklen 1000 --mincluster 1000 --threads 16 ${REF} ${HIFIASM}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/hifiasm_vs_ref.delta > ${out_dir}/hifiasm_vs_ref.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${REF} -Q ${HIFIASM} --filter -t png --large --layout --fat -p hifiasm_vs_ref hifiasm_vs_ref.filtered.delta
 
# LJA vs reference 
apptainer exec --bind /data ${CONTAINER} nucmer --prefix lja_vs_ref --breaklen 1000 --mincluster 1000 --threads 16 ${REF} ${LJA}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/lja_vs_ref.delta > ${out_dir}/lja_vs_ref.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${REF} -Q ${LJA} --filter -t png --large --layout --fat -p lja_vs_ref lja_vs_ref.filtered.delta

# flye vs hifiasm
apptainer exec --bind /data ${CONTAINER} nucmer --prefix flye_vs_hifiasm --breaklen 1000 --mincluster 1000 --threads 16 ${FLYE} ${HIFIASM}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/flye_vs_hifiasm.delta > ${out_dir}/flye_vs_hifiasm.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${FLYE} -Q ${HIFIASM} --filter -t png --large --layout --fat -p flye_vs_hifiasm flye_vs_hifiasm.filtered.delta
 
# flye vs lja
apptainer exec --bind /data ${CONTAINER} nucmer --prefix flye_vs_lja --breaklen 1000 --mincluster 1000 --threads 16 ${FLYE} ${LJA}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/flye_vs_lja.delta > ${out_dir}/flye_vs_lja.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${FLYE} -Q ${LJA} --filter -t png --large --layout --fat -p flye_vs_lja flye_vs_lja.filtered.delta
 
# hifiasm vs lja
apptainer exec --bind /data ${CONTAINER} nucmer --prefix hifiasm_vs_lja --breaklen 1000 --mincluster 1000 --threads 16 ${HIFIASM} ${LJA}
apptainer exec --bind /data ${CONTAINER} bash -c "delta-filter -1 ${out_dir}/hifiasm_vs_lja.delta > ${out_dir}/hifiasm_vs_lja.filtered.delta"
apptainer exec --bind /data ${CONTAINER} mummerplot -R ${HIFIASM} -Q ${LJA} --filter -t png --large --layout --fat -p hifiasm_vs_lja hifiasm_vs_lja.filtered.delta