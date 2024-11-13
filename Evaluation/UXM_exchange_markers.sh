
#1.CelFIE markers 
#Directly using the celfie markers as input, since the celfie markers do not fully conform to the uxm input, additional processing with bedtools merge was performed, and markers containing multiple target cell types after merging were removed.

awk '{print $1 "\t" $2 "\t" $3}'/celfie_markers.txt > /~/CelFiE_region.bed
bedtools merge -i /~/CelFiE_region.bed > /~/CelFiE_region2.bed
wgbstools convert -L /~/CelFiE_region2.bed --genome hg38 --out_path /~/CelFiE_cpg.bed
mkdir -p /~/CelFiE/homog
wgbstools homog -b /~/CelFiE/CelFiE_cpg_sorted.bed -o /~/CelFiE/homog --genome hg38 --thresholds 0.25,0.75 /~/ref/*pat.gz 
awk -F, '{print $1 "\t" $2 "\t" $3 "\t" $4}' /~/celfie_target_methy.csv > /~/CelFiE_region_test.bed
bedtools sort -i /~/CelFiE_region_test.bed > /~/CelFiE_region_test_sorted.bed 
bedtools merge -i /~/CelFiE_region_test_sorted.bed -c 4 -o collapse  > /~/CelFiE_region_test_markers.bed 
#From this, the file Atlas.U15.l5.hg38.tsv was created.

for dis in cfsort_dis uniform_dis dirichlet_dis
do
  mkdir -p /~/CelFiE/deconv_out/$dis/
  uxm deconv /sample/$dis/*pat.gz \
   -o /~/deconv_out/$dis/CelFiE_${dis}_deconv.csv \
   --atlas /~/CelFiE/Atlas.U15.l5.hg38.tsv
done

#2.CelFEER markers (Similar to the CelFiE processing workflow.)

awk -F, '{print $1 "\t" $2 "\t" $3}' /～/celfeer_target_methy.csv > /～/CelFEER_region.bed
bedtools sort -i /～/CelFEER_region.bed > /～/CelFEER_region_sorted.bed
bedtools merge -i /～/CelFEER_region_sorted.bed > /～/CelFEER_region2.bed
wgbstools convert -L /～/CelFEER_region2.bed --genome hg38 --out_path /～/CelFEER_cpg.bed
mkdir -p /～/homog
wgbstools homog -b /～/CelFEER_cpg_sorted.bed \
 -o /～/homog --genome hg38 --thresholds 0.25,0.75 /～/ref/*pat.gz 
awk -F, '{print $1 "\t" $2 "\t" $3 "\t" $4}' /～/celfeer_target_methy.csv  > /～/CelFEER_target.bed
bedtools sort -i /～/CelFEER_target.bed > /～/CelFEER_target_sorted.bed
bedtools merge -i /～/CelFEER_target_sorted.bed -c 4 -o collapse  > /～/CelFEER_target_markers.bed 

for dis in cfsort_dis uniform_dis dirichlet_dis
do
  mkdir -p /～/deconv_out/$dis/
  uxm deconv /sample/$dis/*pat.gz  -o /~/deconv_out/$dis/CelFEER_${dis}_deconv.csv --atlas /~/Atlas.U15.l5.hg38.tsv
done

#3.MethAtlas markers 
#Extract the point coordinates from the MethAtlas marker file.

awk -F, '{print $1 "\t" $2 "\t" $3+1}' methatlas_markers.csv > /~/MethAtlas/site_test.bed
bedtools merge -i /~/MethAtlas/site_test.bed > /~/exchange_markers/MethAtlas/site2.bed
wgbstools convert -L /~/MethAtlas/site2.bed --genome hg38 --out_path /~/MethAtlas/cpg_region.bed 
mkdir -p /~/exchange_markers/MethAtlas/homog
wgbstools homog -b /~/MethAtlas/cpg_region.bed -o /~/exchange_markers/MethAtlas/homog --genome hg38 --thresholds 0.25,0.75 /~/ref/*pat.gz -f 
awk -F, '{print $1 "\t" $2 "\t" $3+1 "\t" $5}' /~/top_with_label_se.csv  > /~/MethAtlas/target.bed
bedtools merge -i /~/MethAtlas/target.bed -c 4 -o collapse > /~/MethAtlas/target_merge.bed

for dis in cfsort_dis uniform_dis dirichlet_dis
do
  mkdir -p /~/MethAtlas/deconv_out/$dis/
  uxm deconv /sample/$dis/*pat.gz -o /~/MethAtlas/deconv_out/$dis/MethAtlas_${dis}_deconv.csv --atlas /~/MethAtlas/Atlas.U15.l5.hg38.tsv
done 
