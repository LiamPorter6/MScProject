#!/bin/bash
echo " "


# IDENTIFYING CANDIDATE SOMATIC MUTAIONS 

# isolate pon filtered variants (filtered only due to PoN)
(echo '##fileformat=VCFv4.2'; zcat ../aThesis/LUAD/VCF/*.wxs.MuTect2.somatic_annotation.vcf.gz | awk '{ if($7=="panel_of_normals") print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$11}' | sort -k1,1V -k2,2n) > pon_filtered_variants.vcf

# isolate due to PoN but can include other filters
#(echo '##fileformat=VCFv4.2'; zcat ../aThesis/LUAD/VCF/*.wxs.MuTect2.somatic_annotation.vcf.gz | awk '{ if($7 ~ /panel_of_normals/) print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$11}' | sort | uniq | sort -k1,1V -k2,2n) > pon_filtered_variants.vcf

        # $1 = chr      $2 = pos        $3 = rsID       $4 = ref allele         $5 = alt allele
        # $7 = filter   $11 = info




# intersecting the dataset variants with the PoN
bedtools intersect -a pon_filtered_variants.vcf -b ../aThesis/MuTect2.PON.4136.vcf.gz | cut -f1-6 > dataset.records.tmp

bedtools intersect -a ../aThesis/MuTect2.PON.4136.vcf.gz -b pon_filtered_variants.vcf | cut -f1-6 > pon.records.tmp

# displays the variants filtered next to corrisponding PoN positons
paste dataset.records.tmp pon.records.tmp > filter.map.txt




# isolate variants that have a different alt allele than the PoN
#awk '{if($11!=$5 && $11 !~ $5"," && $11 !~ ","$5) print $0}' filter.map.txt > candidates.filter.map.txt

# isolate variants that rs IDs match the PoN
awk '{if($11!=$5 && $11 !~ $5"," && $11 !~ ","$5 && $3==$9 && $3 != "." && $9 != ".") print $0}' filter.map.txt > candidates.filter.map.txt 

# isolate candidate vairants to identify all occurences in the dataset
cut -f1,2,3,4,5 candidates.filter.map.txt | uniq > uniq_candidates.txt
grep -f uniq_candidates.txt pon_filtered_variants.vcf > candidate_variants.txt
echo "candidate somatic variants filtered: $(wc -l < candidate_variants.txt)"
# number of bases associated with these variants
echo "Number of bases associated: $(awk '{print $4}' candidate_variants.txt | awk '{sum += length($0)} END {print sum}')"
echo " "




# isolate variants that do having matching alt alleles to compare to the candidate variants
#awk '{if($11==$5) print $0}' filter.map.txt > normal_SNPs.filter.map.txt

# rs IDs match PoN
awk  '{if($11==$5 && $11 !~ $5"," && $11 !~ ","$5 && $3==$9 && $3 != "." && $9 != ".") print $0}' filter.map.txt > normal_SNPs.filter.map.txt 

# isolate the normal SNPs and identify occurences in dataset
cut -f1,2,3,4,5 normal_SNPs.filter.map.txt | uniq > uniq_normal_SNPs.txt
grep -f uniq_normal_SNPs.txt pon_filtered_variants.vcf > normal_SNPs.txt
echo "normal SNPs filtered: $(wc -l < normal_SNPs.txt)"
# number of bases associated
echo "Number of bases associated: $(awk '{print $4}' normal_SNPs.txt | awk '{sum += length($0)} END {print sum}')"
echo " "




rm pon_filtered_variants.vcf
rm dataset.records.tmp
rm pon.records.tmp
rm filter.map.txt
rm candidates.filter.map.txt
rm normal_SNPs.filter.map.txt
rm uniq_candidates.txt
rm uniq_normal_SNPs.txt


