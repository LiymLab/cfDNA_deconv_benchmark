#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	python ~/celfeer/scripts/markers.py ~/celfeer_work1/ref_data.txt ~/celfeer_work1/median_${i}/markers_median_${i}.txt 100 35 ${i} 0 True original
	Rscript ./celfeer_data.R $workPath/celfeer_work1/median_depth_filter/median_${i}/markers_median_${i}.txt $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt
	cat $workPath/celfeer_work1/colnames.txt $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt > $workPath/celfeer_work1/median_depth_filter/median_${i}/full_data_input_median_${i}.txt
	rm $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt
	python ~/celfeer/scripts/celfeer.py ~/celfeer_work1/median_${i}/full_data_input_median_${i}.txt ~/celfeer_work1/median_${i}/output_median_${i} 100 -u 0
	Rscript ./celfeer_transform.R ~/celfeer_work1/median_depth_filter/median_${i}/median_${i}_output/1_tissue_proportions.txt ~/celfeer_work1/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv
	python ../../../celfie_work/celfie_uniform/rmse_pearson_ca_celfie.py ~/celfeer_work1/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv ~/celfeer_work1/median_depth_filter/median_${i}/rmse_result_median_${i}.csv ~/celfeer_work1/median_depth_filter/median_${i}/pearson_result_median_${i}.csv
done


