#!/bin/bash

##CelFiE_workflow##
# CelFiE_deconvolution
# For data of different distributions, the workflow is the same

workplace = 'path/workplace' # the path for storing input files

# Generate reference methylation atlas
# Modify parameters including input_file, output_file, summed_file, number_tissues and depth_filter in tim.sh which CelFiE offers according to actual demands to generate reference methylation atlas

# Deconvolution
# data_input: input file for deconvolution
# sample_output: folder storing deconvolution results
python celfie/scripts/celfie.py ${workplace}/data_input ${workplace}/sample_output 100 -u 0
