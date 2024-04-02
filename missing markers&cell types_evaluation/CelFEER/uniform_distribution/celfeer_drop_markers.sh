#!/bin/bash

#use celfeer_drop_data.R to randomly drop some markers from complete data
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	Rscript celfeer_drop_markers.R ~/celfeer_work1/celfeer_drop_markers/median_${i}/full_data_input_median_${i}.txt median_${i}
done
wait

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	for j in 0.1 0.2 0.3 0.4 0.5
	do
		for k in {1..20}
		do 
			#generate full data
			cat $workPath/celfeer_work1/colnames.txt $workPath/celfeer_work1/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt > $workPath/celfeer_work1/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/full_data_median_${i}_drop_${j}_${k}.txt
			
			rm $workPath/celfeer_work1/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt
			
			#use celfeer.py for deconvolution
			python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work1/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/full_data_median_${i}_drop_${j}_${k}.txt /home/zyc/celfeer_work1/celfeer_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/output_median_${i}_drop_${j}_${k} 100 -u 0
		done
	done
done


