#!/bin/bash

##CelFEER_workflow##
# Evaluation of sequencing depth filter thresholds in the reference methylation atlas
# For data of different distributions, the workflow is the same

workplace = 'path/workplace' # You can set your own work path

# deconvolution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100 150 200 250 300
do
	# select markers
	python celfeer/scripts/markers.py ${workplace}/ref_data.txt ${workplace}/median_${i}/markers_median_${i}.txt 100 35 ${i} 0 True original
	
	# generate the full data according to the selected markers
	Rscript ./celfeer_data.R ${workplace}/median_depth_filter/median_${i}/markers_median_${i}.txt ${workplace}/median_depth_filter/median_${i}/data_input_median_${i}.txt
	
	cat ${workplace}/colnames.txt ${workplace}/median_depth_filter/median_${i}/data_input_median_${i}.txt > ${workplace}/median_depth_filter/median_${i}/full_data_input_median_${i}.txt
	
	rm ${workplace}/median_depth_filter/median_${i}/data_input_median_${i}.txt

	# use celfeer.py for deconvolution
	python celfeer/scripts/celfeer.py ${workplace}/median_${i}/full_data_input_median_${i}.txt ${workplace}/median_${i}/output_median_${i} 100 -u 0
done


