#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	Rscript ./celfeer_drop_data.R ~/celfeer_work2/median_depth_filter/median_${i}/full_data_input_median_${i}.txt median_${i}
done
wait

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	for j in 0.1 0.2 0.3 0.4 0.5
	do
		for k in {1..20}
		do
			cat ~/celfeer_work1/colnames.txt ~/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt > ~/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/full_data_median_${i}_drop_${j}_${k}.txt
			rm ~/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt
			python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/full_data_median_${i}_drop_${j}_${k}.txt /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/output_median_${i}_drop_${j}_${k} 100 -u 0
			Rscript ../../../celfie_work/celfie_uniform/celfie_drop_markers/transform.R /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/median_${i}_drop_${j}_${k}_output/1_tissue_proportions.txt /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/t_tissue_proportions_median_${i}_drop_${j}_${k}.csv
			python ../rmse_pearson_ca_celfie.py /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/t_tissue_proportions_median_${i}_drop_${j}_${k}.csv /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/rmse_result_median_${i}_drop_${j}_${k}.csv /home/zyc/celfeer_work2/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/pearson_result_median_${i}_drop_${j}_${k}.csv
		done
	done
done
wait

Rscript ./celfeer_drop_markers.R

