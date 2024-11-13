#!/bin/bash

##CelFEER_workflow##
# Evaluation of the impact of sequencing depth in the sample data

workplace='/path/workplace'

# create sample data according to the markers found before
create_data(){
  i=${1}
  j=${2}
  Rscript ./create_sample.R ${i} ${j}
}

export -f create_data

parallel -j 12 create_data :::  uniform crd dirichlet ::: 1 5 10 15

# Then, paste the reference data and samples data together in a fixed order and assign corresponding column names to form the final input file

# deconvolution
deconv(){
  i=${1}
  j=${2}
  python /celfeer/scripts/celfeer.py ${workplace}/celfeer_sample_ds_${i}/${j}/full_data_input.txt ${workplace}/celfeer_sample_ds_${i}/${j}/output 100 -u 0
}

export -f deconv

parallel -j 12 deconv ::: 1 5 10 15 ::: uniform crd dirichlet