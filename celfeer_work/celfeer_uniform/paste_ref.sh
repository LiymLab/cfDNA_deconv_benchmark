#!/bin/bash
for i in Adipocytes	Bladder-Ep	Blood-B	Blood-Granul	Blood-Mono+Macro	Blood-NK	Blood-T	Breast-Basal-Ep	Breast-Luminal-Ep	Colon-Ep	Colon-Fibro	Endothelium	Eryth-prog	Fallopian-Ep	Gastric-Ep	Head-Neck-Ep	Heart-Cardio	Heart-Fibro	Kidney-Ep	Liver-Hep	Lung-Ep-Alveo	Lung-Ep-Bron	Neuron	Oligodend	Ovary+Endom-Ep	Pancreas-Acinar	Pancreas-Alpha	Pancreas-Beta	Pancreas-Delta	Pancreas-Duct	Prostate-Ep	Skeletal-Musc	Small-Int-Ep	Smooth-Musc	Thyroid-Ep
do
	paste ./regions_ref.txt ./progress_data/${i}_data.txt > ./ref_data.txt
	mv -f ./ref_data.txt ./regions_ref.txt 
done
mv -f ./regions_ref.txt ./ref_data.txt
