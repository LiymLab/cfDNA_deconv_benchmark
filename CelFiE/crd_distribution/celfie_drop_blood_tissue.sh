#!/bin/bash
for j in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
    #use celfie_drop_tissue.R to drop the data of selected cell types from the complete file
	Rscript ./celfie_drop_blood_tissue.R ~/celfie_work2/median_depth_filter/median_15/data_input_median_15.txt ${j}
	
	#use celfie.py for deconvolution
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/data_median_15_drop_${j}_output 100 -u 1
done

#use celfie_drop_tissues.R to drop datas of selected tissues
Rscript ./celfie_drop_blood_tissues.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	#use celfie.py for deconvolution
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done
