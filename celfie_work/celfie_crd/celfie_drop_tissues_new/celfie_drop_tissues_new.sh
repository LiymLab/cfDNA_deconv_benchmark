#!/bin/bash
Rscript ./celfie_drop_tissues.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done
wait

Rscript ./celfie_drop_tissues_data_transform.R

Rscript ./celfie_drop_tissues_make_crd_matrix.R

for i in Blood-NK_Lung-Ep-Alveo Blood-Granul_Colon-Fibro Blood-Mono+Macro_Bladder-Ep Blood-B_Oligodend Blood-T_Skeletal-Musc
do
	python ../../celfie_uniform/celfie_drop_tissue/rmse_pearson_ca_celfie.py ~/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/t_tissue_proportions.csv ~/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/crd_matrix.csv ~/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/rmse_result_drop_${i}.csv ~/celfie_work2/celfie_drop_tissues_new/data_median_15_drop_${i}/pearson_result_drop_${i}.csv
done
wait

Rscript ./celfie_drop_tissue_combine_results.R
