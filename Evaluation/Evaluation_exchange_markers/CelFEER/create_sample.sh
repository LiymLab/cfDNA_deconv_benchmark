#!/bin/bash

##CelFEER_workflow##
# Evaluation of the performance of markers selected by CelFiE, UXM, cfNOMe/MethAtlas
# For markers of different methods, the workflow is the same, the differences have been marked in the cited code

Rscript ./ref.R

workplace='/path/workplace'

create_sample(){
  i=${1}
  
  Rscript ${workplace}/sample.R ${i}
}

export -f create_sample

parallel -j 3 create_sample ::: uniform crd dirichlet
wait

# Then, paste the reference data and samples data together in a fixed order and assign corresponding column names to form the final input file

celfeer_deconv(){
  j=${1}
  python /celfeer/scripts/celfeer.py ${workplace}/${j}/full_data_input.txt ${workplace}/${j}/output 100 -u 0
}

export -f celfeer_deconv

parallel -j 3 celfeer_deconv ::: uniform crd dirichlet
