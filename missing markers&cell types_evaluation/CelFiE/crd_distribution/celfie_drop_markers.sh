#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use drop_data.R to randomly drop markers from complete data
	Rscript ../uniform_distribution/drop_markers.R ~/celfie_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt median_${i}
done
wait

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	for j in 0.1 0.2 0.3 0.4 0.5
	do
		for k in {1..20}
		do
		  #use celfie.py for deconvolution
			python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/data_median_${i}_drop_${j}_${k}.txt /home/zyc/celfie_work2/celfie_drop_markers/median_${i}/median_${i}_drop_${j}_${k}/output_median_${i}_drop_${j}_${k} 100 -u 0
		done
	done
done



