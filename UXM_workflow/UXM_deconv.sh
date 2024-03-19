##UXM_workflow##

**build&deconv**

##Uniform distribution##
#!/bin/bash
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/filter_${i}_markers.bed --groups /home/yjq/UXM_deconv/UXM/uniform_distribution/group.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/uniform_distribution/deconv_out/filter_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv
done

##Constrained random distribution##
##只进行deconv这一步##
for i in 15 20 25 30 35 40 45 50 60 70 80 90 100
do
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/cfsort_distribution/deconv_out/filter_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/uniform_distribution/filter_${i}_markers/Atlas.U${i}.l5.hg38.tsv
done
