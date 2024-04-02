#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use samples_summed.R to sum methylation data and get complete file for deconvolution
	Rscript ./samples_summed.R ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt ~/celfie_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
done


