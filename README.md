# Genome and Transcriptome Assembly
## Repository Overview
This repository contains the project work for the Genome and Transcriptome Assembly course at the University of Bern (autumn 2026). The project covers de novo assembly of the Arabidopsis thaliana accession Hiroshima (genomic DNA) and the accession Sha (RNA-seq), followed by quality control, assembly evaluation and comparative genomics.
All analyses were run on the IBU computing cluster using SLURM.

## Dataset Description
The data used in this project come from Lian et al. (2024).
Sample	Data type	Sequencing	SRA accession
- Hiroshima	Genomic DNA	PacBio HiFi	ERR11437318
- Sha	RNA-seq	Illumina (paired-end)	ERR754081

Reference: Lian, Q. et al. (2024). A pan-genome of 69 Arabidopsis thaliana accessions reveals a conserved genome structure throughout the global species range. Nature Genetics, 56, 982–991.



## Repository Structure

| Folder | Content |
|---|---|
| `Script/` | SLURM scripts for each analysis step (run in numbered order) |
| `Fastqc_result/` | FastQC reports of the raw and trimmed reads |
| `Fastp_result/` | fastp trimming reports |
| `K-mer_result/` | Jellyfish k-mer counts and GenomeScope results |
| `Evaluation and Comparative/` | BUSCO, QUAST, Merqury and nucmer/MUMmer results |

## Author
Maisyaroh – MSc Bioinformatics student, University of Bern
