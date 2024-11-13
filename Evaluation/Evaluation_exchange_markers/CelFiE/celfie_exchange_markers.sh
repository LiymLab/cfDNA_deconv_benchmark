#!/bin/bash

##CelFiE_workflow##
# Evaluation of the performance of markers selected by CelFEER, UXM, cfNOMe/MethAtlas
# For markers of different methods, the workflow is the same, the differences have been marked in the cited code

Rscript ./create_ref.R

celfie_exchange_markers(){
  j=${1}
  workplace='/path/workplace'
  fileplace='/path/fileplace'
  
  Rscript samples_summed.R ${workpalce}/intersect_res_new.bed ${workpalce}/sample_input_tims_summed.txt ${fileplace}/${j}_dis ${workpalce}/${j}/data_input.txt
  
  python /celfie/scripts/celfie.py ${workpalce}/${j}/data_input.txt ${workpalce}/${j}/output 100 -u 0
}

export -f celfie_exchange_markers

parallel -j 3 celfie_exchange_markers ::: uniform crd dirichlet
