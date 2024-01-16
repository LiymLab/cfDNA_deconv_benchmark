#!/bin/bash

Rscript ../ref.R

#then, modify some parameters according to actual demands to generate reference methylation atlas

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	cut -f 1-3 ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt > ~/celfie_work1/median_${i}/tims_median_${i}.bed

        bedtools intersect -a ~/celfie_work1/median_${i}/tims_median_${i}.bed -b ~/celfie_work1/bed.bed -wa -wb > ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed

	Rscript ./samples_summed.R ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt ~/celfie_work1/median_${i}/data_input_median_${i}.txt

	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_work1/median_${i}/data_input_median_${i}.txt ~/celfie_work1/median_${i}/sample_output_median_${i} 100 -u 0

	Rscript ./transform.R ~/celfie_work1/median_${i}/sample_output_median_${i}/1_tissue_proportions.txt ~/celfie_work1/median_${i}/t_tissue_proportions_median_${i}.csv

	python ../rmse_pearson_ca_celfie.py ~/celfie_work1/median_${i}/t_tissue_proportions_median_${i}.csv ~/celfie_work1/median_${i}/rmse_result_median_${i}.csv ~/celfie_work1/median_${i}/pearson_result_median_${i}.csv
done
wait

Rscript ./combine_results.R
