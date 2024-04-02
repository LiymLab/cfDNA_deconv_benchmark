#!/bin/bash

#create full data
Rscript ref.R

Rscript sample.R

for i in Adipocytes	Bladder-Ep	Blood-B	Blood-Granul	Blood-Mono+Macro	Blood-NK	Blood-T	Breast-Basal-Ep	Breast-Luminal-Ep	Colon-Ep	Colon-Fibro	Endothelium	Eryth-prog	Fallopian-Ep	Gastric-Ep	Head-Neck-Ep	Heart-Cardio	Heart-Fibro	Kidney-Ep	Liver-Hep	Lung-Ep-Alveo	Lung-Ep-Bron	Neuron	Oligodend	Ovary+Endom-Ep	Pancreas-Acinar	Pancreas-Alpha	Pancreas-Beta	Pancreas-Delta	Pancreas-Duct	Prostate-Ep	Skeletal-Musc	Small-Int-Ep	Smooth-Musc	Thyroid-Ep
do
	paste ./regions_ref.txt ./progress_data/${i}_data.txt > ./ref_data.txt
	mv -f ./ref_data.txt ./regions_ref.txt 
done
mv -f ./regions_ref.txt ./ref_data.txt
wait

for i in {1..100}
do
	paste ./regions_sample.txt ./sample_data/sample_${i}_data.txt > ./sample_data.txt
	mv -f ./sample_data.txt ./regions_sample.txt 
done
mv -f ./regions_sample.txt ./sample_data.txt

paste sample_data.txt ref_data.txt > data_full.txt

#deconvolution
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	#select markers
	python ~/celfeer/scripts/markers.py ~/celfeer_work1/ref_data.txt ~/celfeer_work1/median_${i}/markers_median_${i}.txt 100 35 ${i} 0 True original
	
	#generate the full data according to the selected markers
	Rscript ./celfeer_data.R $workPath/celfeer_work1/median_depth_filter/median_${i}/markers_median_${i}.txt $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt
	
	cat $workPath/celfeer_work1/colnames.txt $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt > $workPath/celfeer_work1/median_depth_filter/median_${i}/full_data_input_median_${i}.txt
	
	rm $workPath/celfeer_work1/median_depth_filter/median_${i}/data_input_median_${i}.txt
done


