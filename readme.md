##Data preProcessing##
======================
This segment plays a pivotal role in handling data preprocessing for the entire benchmarking endeavor. The foundational dataset we work with here comprises .pat.gz and .beta files.

The ordered workflow proceeds as:

1. Generate two distribution files to facilitate the creation of cfdna mixtures in subsequent research.
2. Perform data preprocessing, including categorization and the generation of data required for further study.

If your starting point is bam files, it is advisable to preliminarily undergo pertinent transformation procedures by employing wgbstools, which can be found within the official repository at https://github.com/nloyfer/wgbs_tools/tree/master. This step ensures that your data is appropriately formatted for further analysis in the context of this study.

##Five deconvolution methods workflow##
=======================================
The following section is mainly used to demonstrate the workflow of the five cfDNA deconvolution methods. This includes the selection of reference markers, evaluation of sequencing depth thresholds, deconvolution, and evaluation of missing markers/cell types.
If you intend to practically apply this section's code, it is recommended to modify relevant paths and some parameter settings according to your specific requirements. The default sequencing depth threshold is 15.

For MethAtlas, the sequence of steps to follow is:
==================================================
1. Commence with running ‘Depth_filter&markers_selection/MethAtlas/ref_atlas_select.py’ script, which generates MethAtlas's Reference Methylation Atlas for each distinct depth filter level.
2. Next, proceed to execute ‘Depth_filter&markers_selection/MethAtlas/gen_mixture.py’ script, thereby creating FullAtlas.csv files tailored for every individual depth filtering condition.
3. Execute ‘deconvolution/MethAtlas_deconv.ipynb’ script to perform the deconv step.
4. Execution of the contents of the ‘missing markers&cell types_evaluation/MethAtlas/’ folder enables evaluation of the integrity of the reference methylation profile.

It is highly recommended to consult the user guide and preparation detailed within the MethAtlas project on GitHub at https://github.com/nloyfer/meth_atlas before implementing any part of this codebase in your work.

For cfNOMe, the sequence of steps to follow is:
===============================================
1. Before you begin the execution of this workflow, it is important to ensure that the Methylation Reference Atlas has been accurately generated using MethAtlas. 
2. Since the reference methylation atlas used by cfNOMe is consistent with MethAtlas, the primary operation involves converting files utilized in MethAtlas to a format supported by cfNOMe.You can use the contents of the ‘Depth_filter&markers_selection/cfNOMe/’ folder for this step. For more detailed information and assistance, please refer to the content available at https://github.com/FlorianErger/cfNOMe.
3. The deconvolution process can be executed by specifying the appropriate arguments when running the Python script 'deconvolution/cfNOMe_deconv.py'. To do this, use the following command line options: --input-dir {mixture_dir}, --ref-file {path_to_ref_bed}, and --dis {uniform or crd}.
4. Before executing the deconvolution, it's advisable to modify the location of cfNOMe within the 'deconvolution/cfNOMe_deconv.py' file to avoid any potential errors. This ensures that the program correctly references the cfNOMe installation and runs without issues.
5. Execution of the contents of the ‘missing markers&cell types_evaluation/cfNOMe/’ folder enables evaluation of the integrity of the reference methylation profile.

For UXM, the sequence of steps to follow is:
============================================
1. Run 'Depth_filter&markers_selection/UXM/UXM_reference_marker_selection.sh' script to generate reference methylation profiles for UXM for each different depth screening level.
2. The deconvolution process can be performed by specifying appropriate parameters when running the script 'deconvolution/UXM_deconv.sh'.
3. Changing the corresponding file inputs makes it possible to perform evaluations such as cell type missing. You can use ‘missing markers&cell types_evaluation/UXM/UXM_random_drop_cell_type.sh' script to accomplish this step. Before performing this step, make sure that you use previous steps to generate reference methylation markers for cell types that are missing as input.

It is highly recommended to consult the detailed user guide and preparatory work in the UXM_deconv project on GitHub at https://github.com/nloyfer/UXM_deconv before implementing any part of this codebase in your work.

For CelFiE, the sequence of steps to follow is:
===============================================
1. Modify some parameters in tim.sh which CelFiE offers according to actual demands to generate reference methylation atlas for CelFiE for each different depth screening level. About other processing of input file generation, you can run 'Depth_filter&markers_selection/CelFiE/uniform_distribution/celfie_median_depth_filter.sh' and 'Depth_filter&markers_selection/CelFiE/crd_distribution/celfie_median_depth_filter.sh' for different distributions. 
2. The deconvolution process can be performed by specifying appropriate parameters when running the script 'deconvolution/CelFiE_deconv.sh'.
3. To perform evalutions of missing cell types and missing markers, you can run shell scripts in 'missing markers&cell types_evaluation/CelFiE/uniform_distribution/' or 'missing markers&cell types_evaluation/CelFiE/crd_distribution/' accordingly.

For CelFEER, the sequence of steps to follow is:
================================================
1. Run 'Depth_filter&markers_selection/CelFEER/uniform_distribution/median_depth_filter_deconvolution.sh' or 'Depth_filter&markers_selection/CelFEER/crd_distribution/median_depth_filter_deconvolution.sh' to generate reference methylation atlas and input file for CelFEER for each different depth screening level.
2. The deconvolution process can be performed by specifying appropriate parameters when running the script 'deconvolution/CelFEER_deconv.sh'.
3. To perform evaluations of missing cell types and missing markers, you can run shell scripts in 'missing markers&cell types_evaluation/CelFEER/uniform_distribution/' or 'missing markers&cell types_evaluation/CelFEER/crd_distribution/' accordingly.

##Evaluation of reference markers selection## 
=============================================
You can use the contents of the 'Markers_evaluation' folder to evaluate the cell type specificity and balance of the reference markers selected for each deconvolutional method.

1. You can use 'MethyMark_evaluation.sh' script to evaluate the specificity of the methylation reference markers selected for each method in different cell types.
2. You can use 'ImmuMethy_evaluation.sh' script to evaluate the stability of the methylation reference markers selected for each method across diseases.

##Evaluation metrics##
======================
You can use the contents of the 'Evaluation_metrics' folder to calculate Pearson correlation coefficients and root mean squared errors (RMSEs), as well as the proportions of cell types derived from cfDNA mixtures of each known composition.
 
1. You can use ‘cell_type_metrics_evolution.py script’ to compute both Pearson correlation and root mean squared errors (RMSE) between cell type proportions derived from each cfDNA mixture with known compositions. 
2. You can use 'sample_metrics_evolution.py' script to compute Pearson correlation and root mean squared errors (RMSE) between sample proportions derived from cfDNA mixtures of each known composition.
