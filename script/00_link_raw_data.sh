#!/bin/bash

# 00_link_raw_data.sh
# Purpose: Create symlinks to raw data for the assembly annotation course



                  
ACCESSION="Hiroshima"                    
WORKDIR="/data/users/mmaisyaroh/assembly_course"
RAWDATA="/data/courses/assembly-annotation-course/raw_data"

# ---- Go to working directory ----
cd "${WORKDIR}"

# ---- Create symlinks ----
ln -s "${RAWDATA}/${ACCESSION}" ./
ln -s "${RAWDATA}/RNAseq_Sha" ./

# ---- Verify ----
echo "Symlinks created:"
ls -la