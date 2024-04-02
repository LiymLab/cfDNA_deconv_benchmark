##UXM_workflow##
##Before performing this step, make sure that you use previous steps to generate reference methylation markers for cell types that are missing as input files.

**ctp_build_deconv**
#####UXM uniform distribution#####
##drop 1 cell type
for i in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}.bed --groups /home/yjq/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop1_1/dec_out/drop1_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 2 cell type
for i in PB FE BL TC HH
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop2_${i}.bed --groups /home/yjq/UXM_deconv/UXM/cell_type_drop/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_1/drop2_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_1/dec_out/drop2_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_1/drop2_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 1 blood cell type
for i in Blood-B Blood-Granul Blood-Mono+Macro Blood-NK Blood-T
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}.bed --groups /home/yjq/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop1_blood/drop1_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop1_blood/dec_out/drop1_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/ctp_uniform/drop1_blood/drop1_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 2 blood cell type
for i in GC TS BO NL MB
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop2_${i}.bed --groups /home/yjq/UXM_deconv/UXM/cell_type_drop/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_blood/drop2_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/uniform_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_blood/dec_out/drop2_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/ctp_uniform/drop2_blood/drop2_${i}/Atlas.U15.l5.hg38.tsv
done

#####UXM Constrained random distribution#####

##drop 1 cell type
for i in Endothelium Blood-Granul Adipocytes Blood-NK Head-Neck-Ep
do
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz  -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop1_1/dec_out/drop1_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 2 cell type
for i in PB FE BL TC HH
do
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop2_1/dec_out/drop2_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/cell_type_drop/drop2_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 1 blood cell type
for i in Blood-B Blood-Granul Blood-Mono+Macro Blood-NK Blood-T
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop1_${i}.bed --groups /home/yjq/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop1/drop1_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop1/dec_out/drop1_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/ctp_dis2/drop1/drop1_${i}/Atlas.U15.l5.hg38.tsv
done

##drop 2 blood cell type
for i in GC TS BO NL MB
do
	uxm build --markers /home/yjq/UXM_deconv/UXM/cell_type_drop/drop2_${i}.bed --groups /home/yjq/UXM_deconv/UXM/cell_type_drop/group_${i}.csv --pats /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop2_blood/drop2_${i}/Atlas.U15.l5.hg38.tsv -l 5
	uxm deconv /home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis/*pat.gz -o /home/yjq/UXM_deconv/UXM/ctp_dis2/drop2_blood/dec_out/drop2_${i}.csv --atlas /home/yjq/UXM_deconv/UXM/ctp_dis2/drop2_blood/drop2_${i}/Atlas.U15.l5.hg38.tsv
done

