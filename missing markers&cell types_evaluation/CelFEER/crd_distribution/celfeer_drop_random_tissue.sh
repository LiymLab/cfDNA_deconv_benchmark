#!/bin/bash
#drop data
Rscript ./celfeer_drop_random_tissue.R

#deconvolution
#drop one random cell type
for i in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	#create complete input data
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	
	rm data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissue/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissue/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 1
done
wait
#drop two random cell types
for i in Pancreas-Duct_Blood-Granul Fallopian-Ep_Eryth-prog Blood-Mono+Macro_Lung-Ep-Alveo Thyroid-Ep_Colon-Fibro Head-Neck-Ep_Heart-Fibro
do
	#create complete input data
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	
	rm data_median_15_drop_${i}/colnames.txt 
	
	rm data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissues/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissues/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done


