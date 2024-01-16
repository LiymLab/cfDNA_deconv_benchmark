#!/bin/bash
Rscript ./celfeer_drop_tissue.R

for i in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	rm data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 1
done
wait

Rscript ./celfeer_drop_tissue_data_transform.R

Rscript ./celfeer_drop_tissue_make_crd_matrix.R

for j in Blood-NK Blood-Granul Blood-Mono+Macro Blood-B Blood-T
do
	python ../../../celfie_work/celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${j}/t_tissue_proportions.csv /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${j}/crd_matrix.csv /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${j}/rmse_result_drop_${j}.csv /home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_${j}/pearson_result_drop_${j}.csv
done

