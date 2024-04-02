#!/bin/bash

# Modify some parameters according to actual demands to generate reference methylation atlas

#uniform distribution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use celfie.py for deconvolution
	python ~/cfDNA_celfie/celfie/scripts/celfie.py ~/celfie_work1/median_${i}/data_input_median_${i}.txt ~/celfie_work1/median_${i}/sample_output_median_${i} 100 -u 0
done

#constrained random distribution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#use celfie.py for deconvolution
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt /home/zyc/celfie_work2/median_depth_filter/median_${i}/sample_output_median_${i} 100 -u 0
done
