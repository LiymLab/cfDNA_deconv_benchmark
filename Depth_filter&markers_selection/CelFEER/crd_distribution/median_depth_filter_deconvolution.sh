#!/bin/bash
Rscript create_sample_data.R

for i in {1..100}
do
	paste ./regions_sample.txt ./sample_data/sample_${i}_data.txt > ./sample_data.txt
	mv -f ./sample_data.txt ./regions_sample.txt 
done
mv -f ./regions_sample.txt ./sample_data.txt

paste sample_data.txt celfeer_work1/ref_data.txt > data_full.txt

for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
    #create complete input data
	Rscript ./celfeer_data.R ~/celfeer_work1/median_${i}/markers_median_${i}.txt ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
	
	cat ~/celfeer_work1/colnames.txt ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt > ~/celfeer_work2/median_depth_filter/median_${i}/full_data_input_median_${i}.txt
	
	rm ~/celfeer_work2/median_depth_filter/median_${i}/data_input_median_${i}.txt
done