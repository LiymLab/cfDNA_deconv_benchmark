#!/bin/bash
for j in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	#use celfie_drop_tissue.R to drop the data of selected cell types from the complete file
	Rscript ./celfie_drop_random_tissue/celfie_drop_tissue.R ~/celfie_work2/median_depth_filter/median_15/data_input_median_15.txt ${j}

    #use celfie.py for deconvolution
    python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissue/data_median_15_drop_${j}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissue/data_median_15_drop_${j}/data_median_15_drop_${j}_output 100 -u 1
done
wait

#use celfie_drop_tissues.R to drop datas of selected tissues
Rscript ./celfie_drop_random_tissues.R

for i in Blood-Mono+Macro_Lung-Ep-Alveo Fallopian-Ep_Eryth-prog Head-Neck-Ep_Heart-Fibro Pancreas-Duct_Blood-Granul Thyroid-Ep_Colon-Fibro
do
    #use celfie.py for deconvolution
	python /home/zyc/cfDNA_celfie/celfie/scripts/celfie.py /home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_${i}/data_input.txt /home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_${i}/data_median_15_drop_${i}_output 100 -u 2
done

