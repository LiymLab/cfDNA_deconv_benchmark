##UXM_workflow##

**UXM depth filter marker selection**

##Segmentation
wgbstools segment --betas /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*beta --min_cpg 4 --max_bp 5000 -o /home/yjq/UXM_deconv/UXM/uniform_distribution/blocks.small.bed --genome hg38

##Index bed
wgbstools index blocks.small.bed

##DMR

#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	wgbstools find_markers --blocks_path /home/yjq/UXM_deconv/UXM/uniform_distribution/blocks.small.bed.gz --groups /home/yjq/UXM_deconv/UXM/uniform_distribution/group.csv --betas /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*beta --pval 0.05 --min_bp 10 --min_cpg 5 --only_hypo --sort_by delta_means --tg_quant 0.25 --bg_quant 0.025 --top 25 --min_cov ${i} -o /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers
	Rscript ./Modify_marker_column_name.R
	cat /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/*bed > /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/filter_${i}_markers.bed
done
