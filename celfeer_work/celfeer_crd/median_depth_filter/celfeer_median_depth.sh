#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	Rscript ./celfeer_data.R ~/celfeer_work1/median_${i}/markers_median_${i}.txt ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
	cat ~/celfeer_work1/colnames.txt ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt > ~/celfeer_work2/median_depth_filter/median_${i}/full_data_input_median_${i}.txt
	rm ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/median_depth_filter/median_${i}/full_data_input_median_${i}.txt /home/zyc/celfeer_work2/median_depth_filter/median_${i}/output_median_${i} 100 -u 0
	Rscript ../../celfeer_uniform/median_depth_filter/celfeer_transform.R /home/zyc/celfeer_work2/median_depth_filter/median_${i}/median_${i}_output/1_tissue_proportions.txt /home/zyc/celfeer_work2/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv
	python ../rmse_pearson_ca_celfie.py /home/zyc/celfeer_work2/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv /home/zyc/celfeer_work2/median_depth_filter/median_${i}/rmse_result_median_${i}.csv /home/zyc/celfeer_work2/median_depth_filter/median_${i}/pearson_result_median_${i}.csv
done
wait

Rscript ./celfeer_median_depth_filter.R



