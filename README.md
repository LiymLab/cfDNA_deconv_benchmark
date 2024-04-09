Systematic Evaluation of Cell Type Deconvolution Methods for Plasma Cell-free DNA
=================================================================================

This repository contains scripts that were used to generate resutls in paper titled "Systematic Evaluation of Cell Type Deconvolution Methods for Plasma Cell-free DNA".You can access this article via https://biorxiv.org/cgi/content/short/2024.03.25.586507v1.

1. DataProcessing
This file plays a pivotal role in handling data pre-processing for the entire benchmarking endeavor. 
gen_Distributions.ipynb：This script is used to generate two distribution files to facilitate the creation of cfdna mixtures in subsequent research.
preProcessing.ipynb：This script is used to perform data pre-processing, including categorization and generation of data required for further research.

2. Deconvlution
This file contains deconvolution codes for five methods.

3. Evaluation
This file contains codes to evaluate five methods.

3.1 Evaluation_markers
This file is used to evaluate the cell type specificity and homeostasis of the reference markers selected by each deconvolution method
3.1.1 MethyMark_evaluation.sh: This script is to evaluate the specificity of the methylation reference markers selected for each method in different cell types.
3.1.2 ImmuMethy_evaluation.sh: This script is to evaluate the stability of the methylation reference markers selected for each method across diseases.

3.2 Evaluation_depth_filter:
This file contains codes to evaluate the influence of sequencing depth filters.

3.3 Evaluation_missing_markers/cell_type(s)
This file contains codes to assess the impact of missing markers.

3.4 Evaluation_metrics
This file is used to calculate Pearson correlation coefficients and root mean squared errors (RMSE) between cell type or sample proportions derived from each cfDNA mixture with known compositions.
3.4.1 cell_type_metrics_evaluation.py: This script is to compute Pearson correlation and root mean squared errors (RMSE) between cell type proportions derived from each cfDNA mixture with known compositions. 
3.4.2 sample_metrics_evaluation.py: This script is to compute Pearson correlation and root mean squared errors (RMSE) between sample proportions derived from each cfDNA mixture with known compositions. 