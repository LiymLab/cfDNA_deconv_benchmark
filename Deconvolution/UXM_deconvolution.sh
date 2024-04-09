##UXM_workflow##
#UXM_deconvolution

for j in uniform_dis Constrained_random_dis
do
    #Segmentation: Segment the region into homogenously methylated blocks
    #ref_dir/*beta: reference beta files are generated by dataProcessing/preProcessing.ipynb script.
    wgbstools segment --betas ref_dir/*beta --min_cpg 4 --max_bp 5000 -o output_dir/blocks.small.bed --genome hg38

    #Index bed
    wgbstools index output_dir/blocks.small.bed
    
    #DMRs
    wgbstools find_markers --blocks_path output_dir/blocks.small.bed.gz --groups group.csv --betas ref_dir/*beta --pval 0.05 --min_bp 10 --min_cpg 5 --only_hypo --sort_by delta_means --tg_quant 0.25 --bg_quant 0.025 --top 25 --min_cov 15 -o output_dir/selected_markers/filter_15_markers
    cat output_dir/selected_markers/filter_15_markers/*bed > output_dir/selected_markers/filter_15_markers/filter_15_markers.bed
    
    #Reference atlas
    #ref_dir/*pat.gz: reference pat files. Generated by dataProcessing/preProcessing.ipynb script along with beta files from the previous step
    #Please note that UXM_deonv software has restriction on the column names of input markers files, please refer to the GitHub site for UXM_deconv software.
    uxm build --markers output_dir/selected_markers/filter_15_markers/filter_15_markers.bed --groups group.csv --pats ref_dir/*pat.gz -o output_dir/selected_markers/filter_15_markers/Atlas.d15.l5.hg38.tsv -l 5
    
    #Running deconvolution 
    #${j}/*pat.gz: One or more pat files to deconvolve.
    uxm deconv ${j}/*pat.gz -o output_dir --atlas output_dir/selected_markers/filter_15_markers/Atlas.d15.l5.hg38.tsv
done
