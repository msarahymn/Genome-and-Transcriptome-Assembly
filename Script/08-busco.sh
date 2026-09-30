#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=busco
#SBATCH --mail-user=maisyaroh.maisyaroh@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_BUSCO_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_BUSCO_%j.e
#SBATCH --partition=pshort_el8


in_flye_dir="/data/users/mmaisyaroh/assembly_course/assemblies/flye"
in_hifiasm_dir="/data/users/mmaisyaroh/assembly_course/assemblies/hifiasm"
in_lja_dir="/data/users/mmaisyaroh/assembly_course/assemblies/LJA/"
in_trinity_dir="/data/users/mmaisyaroh/assembly_course/assemblies"
out_dir="/data/users/mmaisyaroh/assembly_course/assemblies/busco"
CONTAINER="/containers/apptainer/busco_5.7.1.sif"

mkdir -p "${out_dir}"
cd "${out_dir}"

apptainer exec --bind /data ${CONTAINER} busco -i ${in_flye_dir}/assembly.fasta --mode genome -l brassicales_odb10 --cpu 16 -o flye --out_path ${out_dir} --download_path ${out_dir}/busco_downloads -f

apptainer exec --bind /data ${CONTAINER} busco -i ${in_hifiasm_dir}/Hiroshima_hifiasm.fa --mode genome -l brassicales_odb10 --cpu 16 -o hifiasm --out_path ${out_dir} --download_path ${out_dir}/busco_downloads -f

apptainer exec --bind /data ${CONTAINER} busco -i ${in_lja_dir}/assembly.fasta --mode genome -l brassicales_odb10 --cpu 16 -o lja --out_path ${out_dir} --download_path ${out_dir}/busco_downloads -f

apptainer exec --bind /data ${CONTAINER} busco -i ${in_trinity_dir}/trinity.Trinity.fasta --mode transcriptome -l brassicales_odb10 --cpu 16 -o trinity --out_path ${out_dir} --download_path ${out_dir}/busco_downloads -f

