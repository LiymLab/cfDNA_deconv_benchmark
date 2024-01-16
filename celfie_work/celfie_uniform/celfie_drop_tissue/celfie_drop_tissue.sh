#!/bin/bash
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	Rscript ./celfie_drop_tissue.R ~/celfie_work1/median_15/data_input_median_15.txt ${j} 15

	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_drop_tissue/data_median_15_drop_${j}/data_input.txt ~/celfie_drop_tissue/data_median_15_drop_${j}/median_15_drop_${j}_output 100 -u 1
done
wait

Rscript ./make_uniform_martrix.R

Rscript ./data_transform.R

for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	python./rmse_pearson_ca_celfie.py ~/celfie_drop_tissue/data_median_15_drop_${j}/t_tissue_proportions.csv ~/celfie_drop_tissue/data_median_15_drop_${j}/uniform_matrix.csv ~/celfie_drop_tissue/data_median_15_drop_${j}/rmse_result_drop_${j}.csv ~/celfie_drop_tissue/data_median_15_drop_${j}/pearson_result_drop_${j}.csv
done