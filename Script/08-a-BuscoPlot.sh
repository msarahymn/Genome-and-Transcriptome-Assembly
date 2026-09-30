#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:30:00
#SBATCH --job-name=busco_plot
#SBATCH --output=/data/users/mmaisyaroh/assembly_course/output_BUSCOplot_%j.o
#SBATCH --error=/data/users/mmaisyaroh/assembly_course/error_BUSCOplot_%j.e
#SBATCH --partition=pshort_el8

cd /data/users/mmaisyaroh/assembly_course/assemblies/busco
apptainer exec --bind /data /containers/apptainer/busco_5.7.1.sif generate_plot.py -wd plot