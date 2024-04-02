#!/bin/bash
#drop one random cell type
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	#use celfie_drop_tissue.R to drop the data of selected cell types from the complete file
	Rscript ./celfie_drop_random_tissue.R ~/celfie_work1/median_15/data_input_median_15.txt ${j} 15

	#use celfie.py for deconvolution
	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_drop_tissue/data_median_15_drop_${j}/data_input.txt ~/celfie_drop_tissue/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done
wait

#drop two random cell types
Rscript ./celfie_drop_random_tissues.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	#use celfie.py for deconvolution
	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_drop_tissues/data_median_15_drop_${i}/data_input.txt ~/celfie_drop_tissues/data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done


