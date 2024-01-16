#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	Rscript ./samples_summed.R ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt ~/celfie_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
	
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt /home/zyc/celfie_work2/median_depth_filter/median_${i}/sample_output_median_${i} 100 -u 0
	
	Rscript ../../median_depth_filter/transform.R ~/celfie_work2/median_depth_filter/median_${i}/median_${i}_output/1_tissue_proportions.txt ~/celfie_work2/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv
        
	python ../rmse_pearson_ca_celfie.py ~/celfie_work2/median_depth_filter/median_${i}/t_tissue_proportions_median_${i}.csv ~/celfie_work2/median_depth_filter/median_${i}/rmse_result_median_${i}.csv ~/celfie_work2/median_depth_filter/median_${i}/pearson_result_median_${i}.csv
done
wait

Rscript ./celfie_median_depth_filter.R