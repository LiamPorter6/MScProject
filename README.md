# Detection and Analysis of Somatic Mutations Overlapping Single Nucleotide Polymorphisms

## Table of Contents

- [Abstract](#abstract)
- [Introduction](#introduction)
- [Methods](#methods)
  - [Data Acquisition](#data-acquisition)
  - [Estimating Somatic Mutation Rate](#estimating-somatic-mutation-rate)
  - [Identifying Candidate Somatic Mutations](#identifying-candidate-somatic-mutations)
  - [Alternate Allele Frequency Comparison](#alternate-allele-frequency-comparison)
  - [Variants Filtered due to PoN + Others, Filter Impact](#variants-filtered-due-to-pon--others-filter-impact)
  - [Somatic Mutation Analysis](#somatic-mutation-analysis)
- [Results](#results)
- [Conclusion](#conclusion)
- [Getting Started](#getting-started)
- [Contact](#contact)

## Abstract

Accurate somatic mutation calling is crucial for understanding cancer at a molecular level, guiding targeted therapies, and personalized medicine. This project focuses on the Panel of Normals (PoN) filter used to filter out germline variants and polymorphisms. While effective, the PoN filter may still eliminate true somatic variants. This study identifies candidate somatic mutations coinciding with SNP positions in the LUAD dataset, where the alternate allele differs from the PoN recorded allele. Results highlight potential somatic mutations that could be overlooked due to filtering.

## Introduction

Somatic variants play a pivotal role in tumor development and treatment. Somatic variant calling pipelines, like MuTect2, are employed to identify such variants. The Panel of Normals (PoN) filter is common in these pipelines to distinguish somatic from germline variants. However, this filter's exclusive focus on genomic positions, not alternate alleles, poses a challenge. Variants with non-matching alternate alleles may be true somatic mutations filtered by PoN. This project aims to explore such candidate somatic mutations within the LUAD dataset.

## Methods

### Data Acquisition

The LUAD dataset, comprising 630 VCF files from TCGA, forms the basis of this study. Using the dbSNP database and hg38 reference genome, LUAD VCF files intersected with the PoN to identify candidate somatic variants.

### Estimating Somatic Mutation Rate

Calculations for true somatic variants and mutation rates provide insights into the expected number of mutated bases within the PoN region.

### Identifying Candidate Somatic Mutations

Filtered variants from the PoN were compared with recorded SNPs to identify candidate somatic mutations. Variants with mismatched alternate alleles were isolated and analyzed.

### Alternate Allele Frequency Comparison

Density plots and statistical tests were used to compare alternate allele frequencies between candidate somatic mutations and regular SNPs.

### Variants Filtered due to PoN + Others, Filter Impact

The impact of additional filters on alternate allele mismatches was assessed by comparing candidate somatic variants and normal SNPs.

### Somatic Mutation Analysis

Candidate somatic mutations were analyzed for recurrence and gene associations using NCBI databases.

## Results

A total of 186,812 candidate somatic variants were identified within the LUAD dataset. The 'PoN filter only with credible rs IDs' group emerged as the most credible for somatic mutations at SNP positions, revealing 513 variants and 29 recurrences.

## Conclusion

This study sheds light on potential somatic mutations overlooked by traditional filtering methods. Understanding the functional impact of these variants could contribute to cancer research and personalized medicine.

For more information, please refer to the [full manuscript](link_to_full_manuscript.pdf).

## Contact

For any questions or inquiries, please contact Liam Porter at l.porter6@universityofgalway.ie.
