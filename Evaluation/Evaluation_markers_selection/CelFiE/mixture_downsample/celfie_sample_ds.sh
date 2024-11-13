#!/bin/bash

##CelFiE_workflow##
# Evaluation of the impact of sequencing depth in the sample data

celfie_sample_ds(){
  file_path='/file/path'
  work_path='/work/path'
  i=${1}
  j=${2}
  
  Rscript /home/zyc/celfie_sample_ds/samples_summed.R ${file_path}/${j}_dis/${j}_${i}/ ${work_path}/bedtools_res_median_15.bed ${work_path}/sample_input_tims_summed_median_15.txt ${work_path}/celfie_sample_ds_${i}/${j}/data_input.txt
  
  python celfeer.py ${work_path}/celfie_sample_ds_${i}/${j}/data_input.txt ${work_path}/celfie_sample_ds_${i}/${j}/output 100 -u 0 
}

export -f celfie_sample_ds

parallel -j 10 celfie_sample_ds ::: 1 5 10 15 ::: uniform crd dirichlet 