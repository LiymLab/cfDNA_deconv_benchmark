#!/bin/bash

##CelFiE_workflow##
# Evaluation of cell type(s) in the reference methylation atlas
# For data of different distributions, the workflow is the same

dataplace = 'path/dataplace' # path storing the data to be processed; You can set your own work path
workplace = 'path/workplace' # You can set your own work path

# drop one random cell type
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	# use celfie_drop_cell_type.R to drop the data of selected cell types from the complete file
	Rscript ./celfie_drop_cell_type.R ${dataplace}/data_input_median_15.txt ${j} 

	# use celfie.py for deconvolution
	python celfie/scripts/celfie.py ${workplace}/data_median_15_drop_${j}/data_input.txt ${workplace}/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done
wait

# drop two random cell types
Rscript ./celfie_drop_cell_types.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	# use celfie.py for deconvolution
	python celfie/scripts/celfie.py ${workplace}/data_median_15_drop_${i}/data_input.txt ${workplace}/data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done
wait

# drop one blood cell type
for j in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
    # use celfie_drop_cell_type.R to drop the data of selected cell types from the complete file
	Rscript ./celfie_drop_cell_type.R ${dataplace}/data_input_median_15.txt ${j}
	
	# use celfie.py for deconvolution
	python celfie/scripts/celfie.py ${workplace}/data_median_15_drop_${j}/data_input.txt ${workplace}/data_median_15_drop_${j}/data_median_15_drop_${j}_output 100 -u 1
done

# drop two blood cell types
Rscript ./celfie_drop_cell_types.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	# use celfie.py for deconvolution
	python celfie/scripts/celfie.py ${workplace}/data_median_15_drop_${i}/data_input.txt ${workplace}/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done

