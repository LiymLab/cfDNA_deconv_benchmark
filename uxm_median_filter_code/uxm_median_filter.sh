#####UXM uniform distribution#####

##Segmentation
wgbstools segment --betas /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*beta --min_cpg 4 --max_bp 5000 -o /home/yjq/UXM_deconv/UXM/uniform_distribution/blocks.small.bed --genome hg38

##Index bed
wgbstools index blocks.small.bed

##DMR

#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	wgbstools find_markers --blocks_path /home/yjq/UXM_deconv/UXM/uniform_distribution/blocks.small.bed.gz --groups /home/yjq/UXM_deconv/UXM/uniform_distribution/group.csv --betas /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*beta --pval 0.05 --min_bp 10 --min_cpg 5 --only_hypo --sort_by delta_means --tg_quant 0.25 --bg_quant 0.025 --top 25 --min_cov ${i} -o /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers
	cat /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/*bed > /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/filter_${i}_markers.bed
done

####先在R中修改列名####

##build&deconv
#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/filter_${i}_markers.bed --groups /home/yjq/UXM_deconv/UXM/uniform_distribution/group.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/uniform_distribution/deconv_out/filter_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv
done

#####UXM cfsort distribution#####
##只进行deconv这一步
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/cfsort_distribution/deconv_out/filter_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv
done
