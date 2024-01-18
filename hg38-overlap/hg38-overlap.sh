#Gastric
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Gastric.bed /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Gastric.bed unMapped
#Esophagus
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Esophagus.bed /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed unMapped
#Adipose_Tissue
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Adipose_Tissue.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed unMapped
#Small_Intestine
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Small_Intestine.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed unMapped
#Aorta
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Aorta.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Aorta.bed unMapped
#Liver
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Liver.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Liver.bed unMapped
#Lung
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Lung.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Lung.bed unMapped
#Neurosphere_Cortex
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Neurosphere_Cortex.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Neurosphere_Cortex.bed unMapped
#Neurosphere_GanEmi
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Neurosphere_GanEmi.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Neurosphere_GanEmi.bed unMapped
#Breast_Luminal_Epithelial
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Breast_Luminal_Epithelial.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed unMapped
#Breast_Myoepithelial
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Breast_Myoepithelial.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed unMapped
#Brain_Germinal_Matrix
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Brain_Germinal_Matrix.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed unMapped
#Ovary
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Ovary.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Ovary.bed unMapped
#Sigmoid_Colon
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Sigmoid_Colon.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed unMapped
#Pancreas
./liftOver /home/sty/cfDNA_benchmark/statistic_data/hg19/Pancreas.bed  /home/user/data/liftOverFiles/hg19ToHg38.over.chain.gz /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed unMapped

cat /home/yjq/hg19/hg38_markers/*hg38_Neurosphere*bed > /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed
cat /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed /home/yjq/hg19/hg38_markers/hg38_Lung.bed /home/yjq/hg19/hg38_markers/hg38_Aorta.bed /home/yjq/hg19/hg38_markers/hg38_Liver.bed > /home/yjq/hg19/hg38_markers/Endothelium.bed

####ma
cd /home/yjq/hg19/ma/

cat /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/*Lung*bed > /home/yjq/hg19/ma/ma_Lung.bed
cat /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/*Colon*bed > /home/yjq/hg19/ma/ma_Colon.bed
cat /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/*Pancreas*bed > /home/yjq/hg19/ma/Pancreas.bed 

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > Gastric-Ep.txt 
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Adipocytes.bed -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > Adipocytes.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > Head-Neck-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > Small-Int-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > Smooth-Musc.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u > liver.txt
bedtools intersect -a /home/yjq/hg19/ma/ma_Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > lung.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > Neuron.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > Breast-Basal-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >Oligodend.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > Ovary+Endom-Ep.txt
bedtools intersect -a /home/yjq/hg19/ma/ma_Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u >Colon.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >Endothelium.txt
bedtools intersect -a /home/yjq/hg19/ma/Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > Pancreas.txt

####uxm
cd /home/yjq/hg19/UXM/

cat /home/yjq/UXM_deconv/UXM/filter_15_markers/*Lung*bed > /home/yjq/hg19/UXM/UXM_Lung.bed
cat /home/yjq/UXM_deconv/UXM/filter_15_markers/*Colon*bed > /home/yjq/hg19/UXM/UXM_Colon.bed
cat /home/yjq/UXM_deconv/UXM/filter_15_markers/*Pancreas*bed > /home/yjq/hg19/UXM/UXM_Pancreas.bed 


bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > Gastric-Ep.txt 
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Adipocytes.bed  -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > Adipocytes.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > Head-Neck-Ep.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > Small-Int-Ep.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > Smooth-Musc.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u > liver.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > Neuron.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > Breast-Basal-Ep.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >Oligodend.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > Ovary+Endom-Ep.txt
bedtools intersect -a /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >Endothelium.txt
bedtools intersect -a /home/yjq/hg19/UXM/UXM_Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > lung.txt
bedtools intersect -a /home/yjq/hg19/UXM/UXM_Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u >Colon.txt
bedtools intersect -a /home/yjq/hg19/UXM/UXM_Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > Pancreas.txt



####celfeer marker region
cd /home/yjq/hg19/new/celfeer_region/

cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/*Pancreas-*bed > /home/yjq/hg19/new/celfeer_region/Pancreas.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/*Lung-*bed > /home/yjq/hg19/new/celfeer_region/Lung.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/*Colon-*bed > /home/yjq/hg19/new/celfeer_region/Colon.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > celfeer_region_Gastric-Ep.txt 
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Adipocytes.bed -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > celfeer_region_Adipocytes.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > celfeer_region_Head-Neck-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > celfeer_region_Small-Int-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > celfeer_region_Smooth-Musc.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u > celfeer_region_liver.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > celfeer_region_Neuron.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > celfeer_region_Breast-Basal-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > celfeer_region_Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >celfeer_region_Oligodend.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > celfeer_region_Ovary+Endom-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >celfeer_region_Endothelium.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_region/Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > celfeer_region_Pancreas.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_region/Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > celfeer_region_lung.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_region/Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u >celfeer_region_Colon.txt

####celfeer marker sites
cd /home/yjq/hg19/new/celfie_sites/

cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/*Pancreas-*bed > /home/yjq/hg19/new/celfeer_sites/Pancreas.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/*Lung-*bed > /home/yjq/hg19/new/celfeer_sites/Lung.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/*Colon-*bed > /home/yjq/hg19/new/celfeer_sites/Colon.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > celfeer_sites_Gastric-Ep.txt 
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Adipocytes.bed -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > celfeer_sites_Adipocytes.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > celfeer_sites_Head-Neck-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > celfeer_sites_Small-Int-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > celfeer_sites_Smooth-Musc.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u > celfeer_sites_liver.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > celfeer_sites_Neuron.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > celfeer_sites_Breast-Basal-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > celfeer_sites_Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >celfeer_sites_Oligodend.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > celfeer_sites_Ovary+Endom-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >celfeer_sites_Endothelium.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_sites/Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > celfeer_sites_Pancreas.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_sites/Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > celfeer_sites_lung.txt
bedtools intersect -a /home/yjq/hg19/new/celfeer_sites/Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u > celfeer_sites_Colon.txt

####celfie marker region
cd /home/yjq/hg19/new/celfie_region/

cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/*Pancreas-*bed > /home/yjq/hg19/new/celfie_region/Pancreas.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/*Lung-*bed > /home/yjq/hg19/new/celfie_region/Lung.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/*Colon-*bed > /home/yjq/hg19/new/celfie_region/Colon.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > celfie_region_Gastric-Ep.txt 
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Adipocytes.bed -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > celfie_region_Adipocytes.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > celfie_region_Head-Neck-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > celfie_region_Small-Int-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > celfie_region_Smooth-Musc.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u > celfie_region_liver.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > celfie_region_Neuron.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > celfie_region_Breast-Basal-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > celfie_region_Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >celfie_region_Oligodend.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > celfie_region_Ovary+Endom-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >celfie_region_Endothelium.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_region/Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > celfie_regionn_Pancreas.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_region/Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > celfie_region_lung.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_region/Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u >celfie_region_Colon.txt

####celfie marker sites
cd /home/yjq/hg19/new/celfie_sites/

cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/*Pancreas-*bed > /home/yjq/hg19/new/celfie_sites/Pancreas.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/*Lung-*bed > /home/yjq/hg19/new/celfie_sites/Lung.bed
cat /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/*Colon-*bed > /home/yjq/hg19/new/celfie_sites/Colon.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Gastric-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Gastric.bed -wa -u > celfie_sites_Gastric-Ep.txt 
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Adipocytes.bed -b /home/yjq/hg19/hg38_markers/hg38_Adipose_Tissue.bed -wa -u > celfie_sites_Adipocytes.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Head-Neck-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Esophagus.bed -wa -u > celfie_sites_Head-Neck-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Small-Int-Ep.bed  -b /home/yjq/hg19/hg38_markers/hg38_Small_Intestine.bed -wa -u > celfie_sites_Small-Int-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Smooth-Musc.bed -b /home/yjq/hg19/hg38_markers/hg38_Aorta.bed   -wa -u > celfie_sites_Smooth-Musc.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Liver-Hep.bed -b /home/yjq/hg19/hg38_markers/hg38_Liver.bed -wa -u >celfie_sites_liver.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Neuron.bed -b /home/yjq/hg19/hg38_markers/hg38_Neurosphere.bed -wa -u > celfie_sites_Neuron.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Breast-Basal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Myoepithelial.bed -wa -u > celfie_sites_Breast-Basal-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Breast-Luminal-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Breast_Luminal_Epithelial.bed -wa -u > celfie_sites_Breast_Luminal_Epithelial.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Oligodend.bed -b /home/yjq/hg19/hg38_markers/hg38_Brain_Germinal_Matrix.bed -wa -u >celfie_sites_Oligodend.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Ovary+Endom-Ep.bed -b /home/yjq/hg19/hg38_markers/hg38_Ovary.bed -wa -u > celfie_sites_Ovary+Endom-Ep.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Endothelium.bed -b /home/yjq/hg19/hg38_markers/Endothelium.bed -wa -u >celfie_sites_Endothelium.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_sites/Pancreas.bed -b /home/yjq/hg19/hg38_markers/hg38_Pancreas.bed -wa -u > celfie_sites_Pancreas.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_sites/Lung.bed -b /home/yjq/hg19/hg38_markers/hg38_Lung.bed -wa -u > celfie_sites_lung.txt
bedtools intersect -a /home/yjq/hg19/new/celfie_sites/Colon.bed -b /home/yjq/hg19/hg38_markers/hg38_Sigmoid_Colon.bed -wa -u > celfie_sites_Colon.txt
