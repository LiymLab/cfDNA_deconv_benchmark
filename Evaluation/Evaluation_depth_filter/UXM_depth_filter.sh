##UXM_workflow##
#Evaluation of sequencing depth filter thresholds in the reference methylation atlas

#j: two sets of cfDNA mixture data: Uniform Distribution and constrained Random Distribution
for j in uniform_dis Constrained_random_dis
do
    #Segmentation: segment the region into homogenously methylated blocks
    #ref_dir/*beta: beta files are generated by dataProcessing/preProcessing.ipynb script.
    wgbstools segment --betas ref_dir/*beta --min_cpg 4 --max_bp 5000 -o output_dir/blocks.small.bed --genome hg38
    
    #Index bed
    wgbstools index output_dir/blocks.small.bed
    
    #i: sequencing depth filter thresholds
    for i in 15 20 25 30 35 40 45 50 60 70 80 90 100 
    do
        #DMR
	#ref_dir/*beta: a set of beta files to find the DMR for.
	#group file: a csv table\ text file defining which beta files are case and which are control, or other groups.
	wgbstools find_markers --blocks_path output_dir/blocks.small.bed.gz --groups group.csv --betas ref_dir/*beta --pval 0.05 --min_bp 10 --min_cpg 5 --only_hypo --sort_by delta_means --tg_quant 0.25 --bg_quant 0.025 --top 25 --min_cov ${i} -o output_dir/selected_markers/filter_${i}_markers
	cat output_dir/selected_markers/filter_${i}_markers/*bed > output_dir/selected_markers/filter_${i}_markers/filter_${i}_markers.bed
		
	#Reference atlas
	#ref_dir/*pat.gz: reference pat files. Generated by dataProcessing/preProcessing.ipynb script along with beta files from the previous step
	uxm build --markers output_dir/selected_markers/filter_${i}_markers/filter_${i}_markers.bed --groups group.csv --pats ref_dir/*pat.gz -o output_dir/selected_markers/filter_${i}_markers/Atlas.d${i}.l5.hg38.tsv -l 5
		
	#Running deconvolution 
	#${j}/*pat.gz: one or more pat files to deconvolve.
	#--atlas: path to atlas generated by uxm build.
	uxm deconv ${j}/*pat.gz -o output_dir/depth_filter/${j}_deconv_out/depth_${i}.csv --atlas output_dir/selected_markers/filter_${i}_markers/Atlas.d${i}.l5.hg38.tsv 
    done
done
