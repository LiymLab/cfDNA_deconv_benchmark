Systematic Evaluation of Methylation-based Cell Type Deconvolution Methods for Plasma Cell-free DNA
=================================================================================
This repository contains scripts that were used to generate results in a paper titled "**Systematic Evaluation of Methylation-based Cell Type Deconvolution Methods for Plasma Cell-free DNA**".  

**1. DataProcessing/**: This directory contains scripts for data pre-processing of the benchmark study.<br>
  _gen_Distributions.ipynb_: This script is used to generate two cell type distributions for the generation of cfDNA mixtures.<br>
  _gen_dirichlet.R_: This script is used to generate Dirichlet distribution for the generation of cfDNA mixtures.<br>
  _preProcessing.ipynb_: This script is used to generate reference atlas datasets and the in silico cfDNA mixtures.<br>
  _mix_downsample.py_: This script is used to generate additional in silico datasets with sample sequencing depths of 1, 5, 10, and 15.<br>
  _raw_ref_filter.sh_: This script is used to downsample the raw reference data to average CpG site coverages of 85, 71, 57, 43, 28, 14, and 3.<br>
  _real_world_data_process.sh_: This script is used to process real-world data.
  
**2. Deconvolution/**: This directory contains scripts for cfDNA deconvolution analysis using the five evaluated methods.<br>

**3. Evaluation/**: This directory contains scripts to evaluate the deconvolution performance of the five methods under various scenarios.<br>
	&emsp;&emsp;**3.1 Evaluation_markers_selection/**: This directory stores scripts for evaluating the cell type specificity, non-redundancy, and variability of the reference markers identified by each deconvolution method.<br>
	&emsp;&emsp;_MethyMark_evaluation.sh_: This script is used to evaluate the specificity of the reference markers selected by each method using data from MethyMark database.<br>
	&emsp;&emsp;_ImmuMethy_evaluation.sh_: This script is used to evaluate the variability of the reference markers selected by each method using data from ImmuMethy database.<br>
 	&emsp;&emsp;_cell_type_non-redundancy_evaluation.R_: This script is used to evaluate the non-redundancy of the reference markers.<br>
  	&emsp;&emsp;_cell_type_specificity_evaluation.R_: This script is used to evaluate the specificity of the reference markers.<br>
	&emsp;&emsp;**3.2 Evaluation_sequencing_depth/**: This directory stores scripts to evaluate the influence of sequencing depth filters.<br>
	&emsp;&emsp;**3.3 Evaluation_missing_markers&cell_types/**: This directory stores scripts to assess the impact of missing markers.<br>
 	&emsp;&emsp;**3.4 Evaluation_real-world_datasets/**: This directory stores scripts to assess the deconvolution performance on real-world datasets.<br>
	&emsp;&emsp;**3.5 Evaluation_metrics/**: This directory stores scripts used to calculate root mean squared errors (RMSE), Pearson’s correlation coefficient, Spearman’s rank correlation, Lin’s Concordance Correlation Coefficient (CCC), and Jensen–Shannon divergence (JSD).<br>
	&emsp;&emsp;_sample_metrics_evaluation.R_: This script is used to compute root mean squared errors (RMSE), Pearson’s correlation coefficient, Spearman’s rank correlation, Lin’s Concordance Correlation Coefficient (CCC), and Jensen–Shannon divergence (JSD) between cell type proportions predicted by each cfDNA deconvolution method with the ground-truth cell type proportions.<br>
	&emsp;&emsp;_cal_NPS.R_: This script is used to calculate the normalized performance score (NPS).<br>
 	&emsp;&emsp;_cal_overall_performance.R_: This script is used to summarize the overall performance of each method across different datasets and evaluation factors.

## Authors
- TongYue Sun (suntongyue@foxmail.com)
- Jinqi Yuan (jqyuanjqyuan24@stu.suda.edu.cn)
- Yacheng Zhu (yachengzhu_2002@foxmail.com)
- Yumei Li (yumei.li@uci.edu)
  
