#!/bin/bash

##CelFiE_workflow##
# Evaluation of sequencing depth filter thresholds in the reference methylation atlas
# For data of different distributions, the workflow is the same

workplace = 'path/workplace' # You can set your own work path

# Then, modify some parameters according to actual demands to generate reference methylation atlas

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	# get data of 250bps around selected markers
	cut -f 1-3 ${workplace}/median_${i}/sample_input_tims_summed_median_${i}.txt > ${workplace}/median_${i}/tims_median_${i}.bed

    bedtools intersect -a ${workplace}/median_${i}/tims_median_${i}.bed -b ${workplace}/bed.bed -wa -wb > ${workplace}/median_${i}/bedtools_res_median_${i}.bed

    # use samples_summed.R to sum methylation data and get complete file for deconvolution
    Rscript ./samples_summed.R ${workplace}/median_${i}/bedtools_res_median_${i}.bed ${workplace}/median_${i}/sample_input_tims_summed_median_${i}.txt ${workplace}/median_${i}/data_input_median_${i}.txt

    #use celfie.py for deconvolution
	python celfie/scripts/celfie.py ${workplace}/median_${i}/data_input_median_${i}.txt ${workplace}/median_${i}/sample_output_median_${i} 100 -u 0
done


