#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_merqury_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_merqury_%j.e
#SBATCH --partition=pshort_el8

in_flye_dir="/data/users/mmaisyaroh/assembly_course/assemblies/flye"
in_hifiasm_dir="/data/users/mmaisyaroh/assembly_course/assemblies/hifiasm"
in_lja_dir="/data/users/mmaisyaroh/assembly_course/assemblies/LJA"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/merqury"
CONTAINER="/containers/apptainer/merqury_1.3.sif"



# PacBio HiFi reads (the same file you used for flye / hifiasm / LJA) -> CHECK THIS PATH
READS="/data/users/mmaisyaroh/assembly_course/Hiroshima/ERR11437318.fastq.gz"

FLYE="${in_flye_dir}/assembly.fasta"
HIFIASM="${in_hifiasm_dir}/Hiroshima_hifiasm.fa"
LJA="${in_lja_dir}/assembly.fasta"

# required by the exercise (apptainer passes it into the container)
export MERQURY="/usr/local/share/merqury"


mkdir -p "${out_dir}"
cd "${out_dir}"

# 1) best k-mer size for genome size ~135 Mb (prints ~18.5 -> we use k=19)
apptainer exec --bind /data ${CONTAINER} sh $MERQURY/best_k.sh 135000000

# 2) build the k-mer database from the HiFi reads
apptainer exec --bind /data ${CONTAINER} meryl k=19 count threads=16 memory=60 output ${out_dir}/hifi.meryl ${READS}

# 3) run merqury on each assembly, each in its own folder
mkdir -p ${out_dir}/flye ${out_dir}/hifiasm ${out_dir}/lja

cd ${out_dir}/flye
apptainer exec --bind /data ${CONTAINER} $MERQURY/merqury.sh ${out_dir}/hifi.meryl ${FLYE} flye

cd ${out_dir}/hifiasm
apptainer exec --bind /data ${CONTAINER} $MERQURY/merqury.sh ${out_dir}/hifi.meryl ${HIFIASM} hifiasm

cd ${out_dir}/lja
apptainer exec --bind /data ${CONTAINER} $MERQURY/merqury.sh ${out_dir}/hifi.meryl ${LJA} lja