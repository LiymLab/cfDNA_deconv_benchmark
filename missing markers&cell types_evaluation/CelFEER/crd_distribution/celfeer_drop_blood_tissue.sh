#!/bin/bash
#drop data
Rscript ./celfeer_drop_blood_tissue.R

#deconvolution
#drop one blood cell type
for i in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
  #create complete input data
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	
	rm data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 1
done
wait
#drop two blood cell types
for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	#create complete input data
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	
	rm data_median_15_drop_${i}/colnames.txt 
	
	rm data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done
