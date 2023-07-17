#!/bin/bash
echo " "


# MUTATION RATE

echo "number of VCF files: $(find LUAD/VCF/*MuTect2.somatic_annotation.vcf.gz -type f | wc -l)"
echo " "


echo "true somatic variants (630 VCFs): $(zcat LUAD/VCF/*MuTect2.somatic_annotation.vcf.gz | awk '$7 == "PASS"' | wc -l)"
echo "bases associated: $(zcat LUAD/VCF/*MuTect2.somatic_annotation.vcf.gz | awk '$7 == "PASS" { sum += length($4) } END { print sum }')"
echo " "




# aquire target area of a BAM file
/home/dbennett/bin/samtools-1.16/samtools-1.16.1/samtools depth -q0 BAMs/C509.TCGA-78-7159-01A-11D-2036-08.1_gdc_realn.bam | \
awk 'BEGIN{sum=0; totalNumLoci=0}
     {if($3<10) next; sum+=$3; totalNumLoci++;}
     END{ 
	#print "sum="sum; 
	#print "total number of loci="totalNumLoci; 
	#print "average depth of coverage = "sum/totalNumLoci; 
	print "estimated target size (1 VCF) = "sum/(sum/totalNumLoci);  
	print "estimated target size (630 VCFs) = ~ "(sum/(sum/totalNumLoci))*630}'
echo " "

 ### conduct on more BAM files and average ###

# mutation rate = true somatic variant bases / (average estiated target size X number of VCFs)




#  SNPs IN TARGET REGION

echo " "
# intersect PoN and BAM file to find PoN positions in target region
/home/dbennett/bin/bcftools-1.10/bcftools query -f '%CHROM\t%POS0\t%END\n' LUAD/VCF/MuTect2.PON.4136.vcf.gz > PoN.bed

/home/dbennett/bin/bedtools2/bin/bedtools bamtobed -i BAMs/C509.TCGA-78-7159-01A-11D-2036-08.1_gdc_realn.bam > bam.bed

# unique PoN positions within the target region
/home/dbennett/bin/bedtools2/bin/bedtools intersect -a PoN.bed -b bam.bed -u > overlapping_snps.bed
echo " "
echo "SNPs in target region (1 VCF): $(wc -l overlapping_snps.bed)"
echo " "
echo "SNPs in target region (630 VCFs): $(( $(wc -l < overlapping_snps.bed) * 630 ))"
echo "bases associated: $(( $(awk '{sum += ($3 - $2)} END {print sum}' overlapping_snps.bed) * 630 ))"
echo " "

 ### conduct on multiple bams and average

# SNP density = SNPs in target region / estimated target size of dataset 

# exp somatic mutations in PoN region = SNPs in target region * mutation rate




rm PoN.bed
rm bam.bed
rm overlapping_snps.bed

