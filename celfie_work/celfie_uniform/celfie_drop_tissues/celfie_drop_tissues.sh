#!/bin/bash

Rscript ./celfie_drop_tissues.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_drop_tissues/data_median_15_drop_${i}/data_input.txt ~/celfie_drop_tissues/data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done
wait

Rscript ./make_uniform_matrix.R

Rscript ./data_transform.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	python ../celfie_drop_tissue/rmse_pearson_ca_celfie.py ~/celfie_drop_tissues/data_median_15_drop_${i}/t_tissue_proportions.csv ~/celfie_drop_tissues/data_median_15_drop_${i}/uniform_matrix.csv ~/celfie_drop_tissues/data_median_15_drop_${i}/rmse_result_drop_${i}.csv ~/celfie_drop_tissues/data_median_15_drop_${i}/pearson_result_drop_${i}.csv
done
wait

Rscript ./combine_results.R


