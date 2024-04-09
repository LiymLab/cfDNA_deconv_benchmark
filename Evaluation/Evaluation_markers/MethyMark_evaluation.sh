#!/bin/bash
##Evaluation of reference markers selection##
#MethyMark_evaluation

#convert the genome coordinates of CpGs from hg19 to hg38
for i in Gastric Esophagus Adipose_Tissue Small_Intestine Aorta Liver Lung Neurosphere_Cortex Neurosphere_GanEmi Breast_Luminal_Epithelial Breast_Myoepithelial Brain_Germinal_Matrix Ovary Sigmoid_Colon Pancreas  #15 cell types
do
    ./liftOver ${i}.bed hg19ToHg38.over.chain.gz output_dir_${i}.bed unMapped
    cat Neurosphere*bed > output_dir_Neurosphere.bed
    cat Pancreas.bed Lung.bed Aorta.bed Liver.bed > Endothelium.bed 
done

#Intersect the reference markers identified by each deconvolution method with cell type specific markers in MethyMark for each of the 15 overlapping cell type
#Before proceeding with this step, please make sure that the correct operation was performed by obtaining the correspondence between MethyMark and cell types'ID in this study according to Supplementary Table 5
for i in Meth_atlas UXM CelFeer CelFiE 
do
    for j in Gastric Esophagus Adipose_Tissue Small_Intestine Aorta Liver Lung Neurosphere Breast_Luminal_Epithelial Breast_Myoepithelial Brain_Germinal_Matrix Ovary Sigmoid_Colon Pancreas Endothelium
    do
        bedtools intersect -a ${i}_${j}_markers.bed -b output_dir_${j}.bed > outdir_overlap_${i}_${j}.bed
    done
done
