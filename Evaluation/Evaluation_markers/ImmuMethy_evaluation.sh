#!/bin/bash
##Evaluation of reference markers selection##
#ImmuMethy_evaluation

for i in Bcell Tcell granulocyte monocyte do
    for j in UXM MethAtlas CelFiE celfeer do
        ImmuMethy_file =/ImmuMethy_file/statistic_data/450k/PB_${i}
        Marker_file = /output_dir/selected_markers/${j}_${i}_markers
        ls $ImmuMethy_file/*.bed | while read file ; do
            bedtools intersect -a $file ${Marker_file} -wa -u > /output_dir/immumethy/overlap_${j}_${i}.bed 
        done
    done
done 
