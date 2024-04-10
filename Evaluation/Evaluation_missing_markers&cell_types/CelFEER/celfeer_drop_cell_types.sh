#!/bin/bash

##CelFEER_workflow##
# Evaluation of cell type(s) in the reference methylation atlas
# For data of different distributions, the workflow is the same

#drop data 
Rscript ./celfeer_drop_cell_types.R

workplace = 'path/workplace' # You can set your own work path

#deconvolution
#drop one random cell type
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	#create complete input data
	cat ${workplace}/data_median_15_drop_${j}/colnames.txt ${workplace}data_median_15_drop_${j}/data_input.txt > ${workplace}data_median_15_drop_${j}/full_data_input.txt
	
	rm ${workplace}/data_median_15_drop_${j}/colnames.txt ${workplace}/data_median_15_drop_${j}/data_input.txt
	
	#use celfeer.py for deconvolution
	python celfeer/scripts/celfeer.py ${workplace}/data_median_15_drop_${j}/full_data_input.txt ${workplace}/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done
wait

#drop two random cell types
for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	#create complete input data
	cat ${workplace}/data_median_15_drop_${i}/colnames.txt ${workplace}/data_median_15_drop_${i}/data_input.txt > ${workplace}/data_median_15_drop_${i}/full_data_input.txt
	
	rm ${workplace}/data_median_15_drop_${i}/colnames.txt ${workplace}/data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python celfeer/scripts/celfeer.py ${workplace}//data_median_15_drop_${i}/full_data_input.txt ${workplace}//data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done
wait

#drop one blood cell type
for i in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
  #create complete input data
	cat ${workplace}/data_median_15_drop_${i}/colnames.txt ${workplace}/data_median_15_drop_${i}/data_input.txt > ${workplace}/data_median_15_drop_${i}/full_data_input.txt
	
	rm ${workplace}/data_median_15_drop_${i}/colnames.txt ${workplace}/data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python celfeer/scripts/celfeer.py ${workplace}/data_median_15_drop_${i}/full_data_input.txt ${workplace}/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 1
done
wait

#drop two blood cell types
for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	#create complete input data
	cat ${workplace}/data_median_15_drop_${i}/colnames.txt ${workplace}/data_median_15_drop_${i}/data_input.txt > ${workplace}/data_median_15_drop_${i}/full_data_input.txt
	
	rm ${workplace}/data_median_15_drop_${i}/colnames.txt 
	
	rm ${workplace}/data_median_15_drop_${i}/data_input.txt
	
	#use celfeer.py for deconvolution
	python celfeer/scripts/celfeer.py ${workplace}//data_median_15_drop_${i}/full_data_input.txt ${workplace}/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done