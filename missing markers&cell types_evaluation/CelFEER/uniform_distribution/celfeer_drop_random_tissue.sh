#!/bin/bash
#drop data 
Rscript ./celfeer_drop_random_tissue.R

#deconvolution
#drop one random cell type
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	#create complete input data
	cat data_median_15_drop_${j}/colnames.txt data_median_15_drop_${j}/data_input.txt > data_median_15_drop_${j}/full_data_input.txt
	
	rm data_median_15_drop_${j}/colnames.txt data_median_15_drop_${j}/data_input.txt
	
	#use celfeer.py for deconvolution
	python ~/celfeer/scripts/celfeer.py ~/celfeer_drop_tissue/data_median_15_drop_${j}/full_data_input.txt ~/celfeer_drop_tissue/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done
wait
#drop two random cell types
for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	#create complete input data
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	
	rm data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python ~/celfeer/scripts/celfeer.py ~/celfeer_drop_tissues/data_median_15_drop_${i}/full_data_input.txt ~/celfeer_drop_tissues/data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done
