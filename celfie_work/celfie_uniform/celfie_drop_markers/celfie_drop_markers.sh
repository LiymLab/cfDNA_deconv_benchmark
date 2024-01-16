#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	Rscript ./drop_data.R ~/celfie_work1/median_${i}/data_input_median_${i}.txt median_${i}
done

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	for j in 0.1 0.2 0.3 0.4 0.5
	do
		for k in {1..20}
		do 
			python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt ~/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/output_median_${i}_drop_${j}_${k} 100 -u 0
			Rscript ./transform.R ~/celfie_drop_data_results/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/median_${i}_drop_${j}_${k}/1_tissue_proportions.txt ~/celfie_drop_data_results/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/t_tissue_proportions_median_${i}_drop_${j}_${k}.csv
			python ../rmse_pearson_ca_celfie.py ~/celfie_drop_data_results/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/t_tissue_proportions_median_${i}_drop_${j}_${k}.csv ~/celfie_drop_data_results/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/rmse_result_median_${i}_drop_${j}_${k}.csv ~/celfie_drop_data_results/celfie_drop_data/median_${i}/median_${i}_drop_${j}_${k}/pearson_result_median_${i}_drop_${j}_${k}.csv
		done
	done
done
wait

Rscript ./results.R