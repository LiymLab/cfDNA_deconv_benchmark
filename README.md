Systematic Evaluation of Cell Type Deconvolution Methods for Plasma Cell-free DNA
=================================================================================
This repository contains scripts that were used to generate resutls in paper titled "Systematic Evaluation of Cell Type Deconvolution Methods for Plasma Cell-free DNA".  
1. DataProcessing: This file plays a pivotal role in handling data pre-processing for the entire benchmarking endeavor.<br>
gen_Distributions.ipynb: This script is used to generate two distribution files to facilitate the creation of cfdna mixtures in subsequent research.<br>
preProcessing.ipynb: This script is used to perform data pre-processing, including categorization and generation of data required for further research.
  
2. Deconvolution: This file contains deconvolution codes for five methods.
3. Evaluation: This file contains codes to evaluate five methods.

   3.1 Markers_selection: This file is used to evaluate the cell type specificity and homeostasis of the reference markers selected by each deconvolution method.<br>
&emsp;&emsp;MethyMark_evaluation.sh: This script is to evaluate the specificity of the methylation reference markers selected for each method in different cell types.<br>
&emsp;&emsp;ImmuMethy_evaluation.sh: This script is to evaluate the stability of the methylation reference markers selected for each method across diseases.

   3.2   Evaluation_depth_filter: This file contains codes to evaluate the influence of sequencing depth filters.

   3.3 Evaluation_missing_markers/cell_type(s): This file contains codes to assess the impact of missing markers.

   3.4 Evaluation_metrics: This file is used to calculate the Pearson correlation and the root-mean-square error (RMSE) values.<br>
  &emsp;&emsp;cell_type_metrics_evaluation.py: This script is to compute Pearson correlation and root mean squared errors (RMSE) between the known proportions under uniform/constrained-random-distribution and the predicted proportions from different deconvolution methods.<br>
  &emsp;&emsp;sample_metrics_evaluation.py: This script is to compute Pearson correlation and root mean squared errors (RMSE) between the known proportions of the reference cell types in the 100 cfDNA mixtures and the computed proportions from various deconvolution methods.
