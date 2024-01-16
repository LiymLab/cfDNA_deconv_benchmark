#!/bin/bash
for j in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
	Rscript ./celfie_drop_tissue.R ~/celfie_work2/median_depth_filter/median_15/data_input_median_15.txt ${j}
	
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/data_median_15_drop_${j}_output 100 -u 1
done

Rscript ./celfie_drop_tissue_data_transform.R

Rscript ./celfie_drop_tissue_make_crd_matrix.R

for j in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
	 python ../../celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py ~/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/t_tissue_proportions.csv ~/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/crd_matrix.csv ~/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/rmse_result_drop_${j}.csv ~/celfie_work2/celfie_drop_tissue_new/data_median_15_drop_${j}/pearson_result_drop_${j}.csv
done