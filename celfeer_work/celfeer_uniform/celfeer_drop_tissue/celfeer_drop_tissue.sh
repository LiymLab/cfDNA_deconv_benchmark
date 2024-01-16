#!/bin/bash
Rscript ./celfeer_drop_tissue.R

for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	cat data_median_15_drop_${j}/colnames.txt data_median_15_drop_${j}/data_input.txt > data_median_15_drop_${j}/full_data_input.txt
	rm data_median_15_drop_${j}/colnames.txt data_median_15_drop_${j}/data_input.txt
	python ~/celfeer/scripts/celfeer.py ~/celfeer_drop_tissue/data_median_15_drop_${j}/full_data_input.txt ~/celfeer_drop_tissue/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done

Rscript ./make_uniform_matrix.R

Rscript ./data_transform.R

for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	python ../../../celfie_work/celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py ~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_${j}/t_tissue_proportions.csv ~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_${j}/uniform_matrix.csv ~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_${j}/rmse_result_drop_${j}.csv ~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_${j}/pearson_result_drop_${j}.csv
done
