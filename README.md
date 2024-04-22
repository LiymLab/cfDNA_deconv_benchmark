Systematic Evaluation of Methylation-based Cell Type Deconvolution Methods for Plasma Cell-free DNA
=================================================================================
This repository contains scripts that were used to generate resutls in paper titled "**Systematic Evaluation of Methylation-based Cell Type Deconvolution Methods for Plasma Cell-free DNA**".  

**1. DataProcessing/**: This directory contains scripts for data pre-processing of the benchmark study.<br>
  _gen_Distributions.ipynb_: This script is used to generate two cell type distributions for the generation of cfDNA mixtures.<br>
  _preProcessing.ipynb_: This script is used to generate reference atlas datasets and the in silico cfDNA mixtures.
  
**2. Deconvolution/**: This directory contains scripts for cfDNA deconvolution analysis using the five evaluated methods.<br>

**3. Evaluation/**: This directory contains scripts to evaluate the deconvolution performance of the five methods under various scenarios.<br>
	&emsp;**3.1 Evaluation_markers_selection/**: This directory stores scripts for the evaluation of the cell-type specificity and variability of reference markers selected by each deconvolution method.<br>
	&emsp;_MethyMark_evaluation.sh_: This script is used to evaluate the specificity of the reference markers selected by each method using data from MethyMark database.<br>
	&emsp;_ImmuMethy_evaluation.sh_: This script is used to evaluate the variability of the reference markers selected by each method using data from ImmuMethy database.<br>
	**3.2 Evaluation_depth_filter/**: This directory stores scripts to evaluate the influence of sequencing depth filters.<br>
	**3.3 Evaluation_missing_markers&cell_types/**: This directory stores scripts to assess the impact of missing markers.<br>
	**3.4 Evaluation_metrics/**: This directory stores scripts used to calculate the Pearson correlation and the root-mean-square error (RMSE) values.<br>
	_cell_type_metrics_evaluation.py_: This script is used to compute Pearson correlation and RMSE between the ground-truth cell type proportions and the predicted proportions from different deconvolution methods for each cell type in the reference atlas across 100 cfDNA mixtures.<br>
	_sample_metrics_evaluation.py_: This script is used to compute Pearson correlation and RMSE between the ground-truth cell type proportions and the predicted proportions from different deconvolution methods for each cfDNA mixture.
