#!/bin/bash
Rscript ./celfeer_drop_tissues.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	cat data_median_15_drop_${i}/colnames.txt data_median_15_drop_${i}/data_input.txt > data_median_15_drop_${i}/full_data_input.txt
	rm data_median_15_drop_${i}/colnames.txt 
	rm data_median_15_drop_${i}/data_input.txt
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/full_data_input.txt /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done
wait

Rscript ./celfeer_drop_tissues_data_transform.R

Rscript ./celfeer_drop_tissues_make_crd_matrix.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	python ../../../celfie_work/celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/t_tissue_proportions.csv /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/crd_matrix.csv /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/rmse_result_drop_${i}.csv /home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_${i}/pearson_result_drop_${i}.csv
done
wait

Rscript ./celfeer_drop_tissue_combine_results.R