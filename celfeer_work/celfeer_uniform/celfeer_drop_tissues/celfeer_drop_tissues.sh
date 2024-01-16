#!/bin/bash
Rscript ./celfeer_drop_tissues.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	rm data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt
	python ~/celfeer/scripts/celfeer.py ~/celfeer_drop_tissues/data_median_15_drop_${i}/full_data_input.txt ~/celfeer_drop_tissues/data_median_15_drop_${i}/median_15_drop_${i}_output 100 -u 2
done
wait

Rscript ./make_uniform_matrix.R

Rscript ./data_transform.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
	python ../../../celfie_work/celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py ~/celfeer_drop_tissues/data_median_15_drop_${i}/t_tissue_proportions.csv ~/celfeer_drop_tissues/data_median_15_drop_${i}/uniform_matrix.csv ~/celfeer_drop_tissues/data_median_15_drop_${i}/rmse_result_drop_${i}.csv ~/celfeer_drop_tissues/data_median_15_drop_${i}/pearson_result_drop_${i}.csv
done
wait

Rscript ./combine_results.R
