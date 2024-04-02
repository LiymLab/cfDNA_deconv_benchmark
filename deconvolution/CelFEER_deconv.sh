#!/bin/bash

#uniform distribution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#select markers
	python ~/celfeer/scripts/markers.py ~/celfeer_work1/ref_data.txt ~/celfeer_work1/median_${i}/markers_median_${i}.txt 100 35 ${i} 0 True original
  
  #Create input data accroding to selected markers.
  
	#use celfeer.py for deconvolution
	python ~/celfeer/scripts/celfeer.py ~/celfeer_work1/median_${i}/full_data_input_median_${i}.txt ~/celfeer_work1/median_${i}/output_median_${i} 100 -u 0
done

#constrained random distribution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use celfeer.py for deconvolution
	python /home/zyc/celfeer/scripts/celfeer.py /home/zyc/celfeer_work2/median_depth_filter/median_${i}/full_data_input_median_${i}.txt /home/zyc/celfeer_work2/median_depth_filter/median_${i}/output_median_${i} 100 -u 0
done
