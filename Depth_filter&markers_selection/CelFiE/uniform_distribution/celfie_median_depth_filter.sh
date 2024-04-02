#!/bin/bash

#get data for reference methylation atlas
Rscript ./ref.R

#then, modify some parameters according to actual demands to generate reference methylation atlas


for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#get data of 250bps around selected markers
	cut -f 1-3 ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt > ~/celfie_work1/median_${i}/tims_median_${i}.bed

    bedtools intersect -a ~/celfie_work1/median_${i}/tims_median_${i}.bed -b ~/celfie_work1/bed.bed -wa -wb > ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed

    #use samples_summed.R to sum methylation data and get complete file for deconvolution
    Rscript ./samples_summed.R ~/celfie_work1/median_${i}/bedtools_res_median_${i}.bed ~/celfie_work1/median_${i}/sample_input_tims_summed_median_${i}.txt ~/celfie_work1/median_${i}/data_input_median_${i}.txt
done


