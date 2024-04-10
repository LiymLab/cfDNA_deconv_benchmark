#!/bin/bash

##CelFEER_workflow##
# CelFEER_deconvolution
# For data of different distributions, the workflow is the same

workplace = 'path/workplace' # the path for storing input files

# Generate reference methylation atlas
# ref_data: input file for selecting markers
# markers: result of selected markers
python celfeer/scripts/markers.py ${workplace}/ref_data ${workplace}/markers 100 35 ${i} 0 True original

# Deconvolution
# full_input_data: input file for deconvolution
# output: folder storing deconvolution results
python celfeer/scripts/celfeer.py ${workplace}/full_data_input ${workpalce}/output 100 -u 0
