#!/bin/bash

##CelFiE_workflow##
# Evaluation of the impact of sequencing depth in the raw reference data

workplace='/home/zyc/celfie_ref_ds'

for i in .83 .66 .50 .33 .16 .03
do
	Rscript ./ref.R /home/yjq/data/downsample_benchmark_ref/subsample_${i}/ ${workplace}/celfie_ref_ds_${i}/input.txt 
done
wait

# Then, modify parameters including input_file, output_file, summed_file, number_tissues and depth_filter in tim.sh which CelFiE offers according to actual demands to generate reference methylation atlas

for i in .03 .16 .33 .50 .66 .83
do
  cut -f 1-3 ${workplace}/celfie_ref_ds_${i}/sample_input_tims_summed.txt > ${workplace}/celfie_ref_ds_${i}/tims.bed
  
  bedtools intersect -a ${workplace}/celfie_ref_ds_${i}/tims.bed -b /home/zyc/celfie_work1/bed.bed -wa -wb > ${workplace}/celfie_ref_ds_${i}/bedtools_res.bed
done

celfie_ref_ds(){
  i=${1}
  j=${2}
  
  Rscript ./samples_summed.R ${workplace}/celfie_ref_ds_${i}/bedtools_res.bed ${workplace}/celfie_ref_ds_${i}/sample_input_tims_summed.txt /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/${j}_dis ${workplace}/celfie_ref_ds_${i}/${j}/data_input.txt
  
  python /celfie/scripts/celfie.py /home/zyc/celfie_ref_ds/celfie_ref_ds_${i}/${j}/data_input.txt /home/zyc/celfie_ref_ds/celfie_ref_ds_${i}/${j}/output 100 -u 0
}

export -f celfie_ref_ds

parallel -j 18 celfie_ref_ds ::: .83 .66 .50 .33 .16 .03 ::: uniform cfsort dirichlet

