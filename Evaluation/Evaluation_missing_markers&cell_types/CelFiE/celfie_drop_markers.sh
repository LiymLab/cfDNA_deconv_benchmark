#!/bin/bash

##CelFiE_workflow##
# Evaluation of missing markers
# For data of different distributions, the workflow is the same

dataplace = 'path/dataplace' # path storing the data to be processed; You can set your own work path
workplace = 'path/workplace' # You can set your own work path

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use drop_data.R to randomly drop some markers from complete data
	Rscript ./drop_markers.R ${dataplace}/median_${i}/data_input_median_${i}.txt median_${i}
done
wait

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	for j in 0.1 0.2 0.3 0.4 0.5
	do
		for k in {1..20}
		do 
			#use celfie.py for deconvolution
			python celfie/scripts/celfie.py ${workplace}/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt ${workplace}/median_${i}/median_${i}_drop_${j}_${k}/output_median_${i}_drop_${j}_${k} 100 -u 0
		done
	done
done


