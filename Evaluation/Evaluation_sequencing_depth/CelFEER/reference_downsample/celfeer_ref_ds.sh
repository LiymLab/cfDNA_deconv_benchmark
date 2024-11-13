#!/bin/bash

##CelFEER_workflow##
# Evaluation of the impact of sequencing depth in the raw reference data

workplace='path/workplace'
# create data for generating the reference atlas
create_data(){
  i=${1}
  
  Rscript./ref.R /home/sty/cfDNA_benchmark/celfeer_data/true_onehot/downsample_ref/subsample_${i} ${workplace}/celfeer_ref_ds_${i}/ref_data
}

export -f create_data

parallel -j 5 create_data ::: .83 .66 .50 .33 .16 .03

# Then, paste the reference data together in a fixed order to form a complete input file

# find markers
find_markers(){
  local i=$1
  python /celfeer/scripts/markers.py ${workplace}/celfeer_ref_ds_${i}/ref_data.txt ${workplace}/celfeer_ref_ds_${i}/markers_test.txt 100 35 15 0 True original
}

export -f find_markers

parallel -j 5 find_markers ::: .83 .66 .50 .33 .16 .03

# generate the final complete input file.
colnames="/colnames.txt"
for dir in ${workplace}/*
do
  if [ -d ${dir} ]; then
    uniform_dir=${dir}/uniform
    sample_data_file="/home/zyc/celfeer_work1/right_sample_data.txt"
    ref_data_file=${dir}/ref_data.txt
    if [ -f ${sample_data_file} ] && [ -f ${ref_data_file} ]; then
      paste ${sample_data_file} ${ref_data_file} > ${uniform_dir}/merged_data.txt
      Rscript ${workplace}/celfeer_data.R ${uniform_dir}/merged_data.txt ${dir}/markers_test.txt ${uniform_dir}/merged_data_progress.txt
      cat ${colnames} ${uniform_dir}/merged_data_progress.txt > ${uniform_dir}/full_data_input.txt
      rm ${uniform_dir}/merged_data.txt ${uniform_dir}/merged_data_progress.txt
    fi

    crd_dir=${dir}/crd
    sample_data_file="/home/zyc/celfeer_work2/right_sample_data.txt"
    ref_data_file=${dir}/ref_data.txt
    if [ -f ${sample_data_file} ] && [ -f ${ref_data_file} ]; then
      paste ${sample_data_file} ${ref_data_file} > ${crd_dir}/merged_data.txt
      Rscript ${workplace}/celfeer_data.R ${crd_dir}/merged_data.txt ${dir}/markers_test.txt ${crd_dir}/merged_data_progress.txt
      cat ${colnames} ${crd_dir}/merged_data_progress.txt > ${crd_dir}/full_data_input.txt
      rm ${crd_dir}/merged_data.txt ${crd_dir}/merged_data_progress.txt
    fi

    dirichlet_dir=${dir}/dirichlet_0.5
    sample_data_file="/home/zyc/celfeer_work4/right_sample_data.txt"
    ref_data_file=${dir}/ref_data.txt
    if [ -f ${sample_data_file} ] && [ -f ${ref_data_file} ]; then
      paste ${sample_data_file} ${ref_data_file} > ${dirichlet_dir}/merged_data.txt
      Rscript ${workplace}/celfeer_data.R ${dirichlet_dir}/merged_data.txt ${dir}/markers_test.txt ${dirichlet_dir}/merged_data_progress.txt
      cat ${colnames} ${dirichlet_dir}/merged_data_progress.txt > ${dirichlet_dir}/full_data_input.txt
      rm ${dirichlet_dir}/merged_data.txt ${dirichlet_dir}/merged_data_progress.txt
    fi
  fi
done

#deconvolution
celfeer_ref_ds_deconv(){
  i=${1}
  j=${2}
  python /celfeer/scripts/celfeer.py ${workplace}/celfeer_ref_ds_${i}/${j}/full_data_input.txt ${workplace}/celfeer_ref_ds_${i}/${j}/output 100 -u 0
}

export -f celfeer_ref_ds_deconv

parallel -j 18 celfeer_ref_ds_deconv ::: .83 .66 .50 .33 .16 .03 ::: dirichlet uniform crd

