##Evaluation of reference markers selection##
**ImmuMethy_evaluation**

**Selection of reference markers and overlap of normal immune cells**
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD57negCD8Tnaive_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD57posCD8Teff_normal.statistic.bed  /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD8T_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_naiveCD4Talphabeta_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_naiveCD4T_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_normal.statistic.bed> /home/yjq/450k/normal/Tcell_normal.bed
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_naiveBcell_normal.statistic.bed > /home/yjq/450k/normal/Bcell_normal.bed
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_blood_normal.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/UCB_blood_normal.statistic.bed >/home/yjq/450k/normal/blood_normal.bed

####celfeer marker region
cd /home/yjq/450k/new/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-B.bed -wa -u >/home/yjq/450k/new/normal/celfeer_region.Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >/home/yjq/450k/new/normal/celfeer_region.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Granul.bed  -wa -u >/home/yjq/450k/new/normal/celfeer_region.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed  -wa -u >/home/yjq/450k/new/normal/celfeer_region.Blood_monocyte.txt

####celfeer marker sites:
cd /home/yjq/450k/new/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-B.bed -wa -u >celfeer_sites.Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >celfeer_sites.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Granul.bed  -wa -u >celfeer_sites.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed  -wa -u >celfeer_sites.Blood_monocyte.txt

#####celfie marker region:
cd /home/yjq/450k/new/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-B.bed -wa -u >celfie_region.Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >celfie_region.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Granul.bed  -wa -u >celfie_region.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed  -wa -u >celfie_region.Blood_monocyte.txt

#####celfie marker sites:
cd /home/yjq/450k/new/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-B.bed -wa -u >celfie_sites.Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed -wa -u >celfie_sites.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Granul.bed  -wa -u >celfie_sites.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed  -wa -u >celfie_sites.Blood_monocyte.txt

######UXM
cd /home/yjq/450k/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-B.bed -wa -u >uxm_Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed -wa -u >uxm_Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Granul.bed  -wa -u >uxm_Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed  -wa -u >uxm_Blood_monocyte.txt

###MethAtlas&cfNOMe
cd /home/yjq/450k/normal/
bedtools intersect -a /home/yjq/450k/normal/Bcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-B.bed -wa -u >Blood_B.txt
bedtools intersect -a /home/yjq/450k/normal/Tcell_normal.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >me_Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Granul.bed  -wa -u >me_Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_normal.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed  -wa -u >me_Blood_monocyte.txt

**Selection of reference markers and overlap of all disease immune cells**
cat /home/sty/cfDNA_benchmark/statistic_data/450k/combined/CD3+T_cells.classStats.bed /home/sty/cfDNA_benchmark/statistic_data/450k/combined/CD4+T_cells.classStats.bed /home/sty/cfDNA_benchmark/statistic_data/450k/combined/CD8+T_cells.classStats.bed /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed >/home/yjq/450k/all/all_Tcel.bed

####celfeer marker region
cd /home/yjq/450k/new/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-B.bed -wa -u >celfeer_region.Blood_B.txt
bedtools intersect -a /home/yjq/450k/all/all_Tcel.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >celfeer_region.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Granul.bed  -wa -u >celfeer_region.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed  -wa -u >celfeer_region.Blood_monocyte.txt

####celfeer marker sites:
cd /home/yjq/450k/new/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-B.bed -wa -u >celfeer_sites.Blood_B.txt
bedtools intersect -a /home/yjq/450k/all/all_Tcel.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >celfeer_sites.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Granul.bed  -wa -u >celfeer_sites.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed  -wa -u >celfeer_sites.Blood_monocyte.txt


#####celfie marker region:
cd /home/yjq/450k/new/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-B.bed -wa -u >celfie_region.Blood_B.txt
bedtools intersect -a /home/yjq/450k/all/all_Tcel.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >celfie_region.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Granul.bed  -wa -u >celfie_region.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed  -wa -u >celfie_region.Blood_monocyte.txt

#####celfie marker sites:
cd /home/yjq/450k/new/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-B.bed -wa -u >celfie_sites.Blood_B.txt
bedtools intersect -a /home/yjq/450k/all/all_Tcel.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed -wa -u >celfie_sites.Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Granul.bed  -wa -u >celfie_sites.Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed  -wa -u >celfie_sites.Blood_monocyte.txt

#####UXM
cd /home/yjq/450k/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-B.bed -wa -u >uxm_Blood_B.txt
bedtools intersect -a all_Tcel.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed -wa -u >uxm_Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Granul.bed  -wa -u >uxm_Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed  -wa -u >uxm_Blood_monocyte.txt

#####MethAtlas&cfNOMe
cd /home/yjq/450k/all/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/B_cells.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-B.bed -wa -u >me_Blood_B.txt
bedtools intersect -a all_Tcel.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >me_Blood_T.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/granulocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Granul.bed  -wa -u >me_Blood_granul.txt
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/combined/monocytes.classStats.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed  -wa -u >me_Blood_monocyte.txt

**Selection of reference markers and overlap of individual disease immune cells**
####B cell
cd /home/yjq/450k/every_cell_type/bcell/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-B.bed -wa -u >Bcell_RA.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-B.bed  -wa -u >Bcell_RA.uxm.bed

cd
cd /home/yjq/450k/new/every_cell_type/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-B.bed -wa -u >Bcell_RA.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-B.bed -wa -u >Bcell_RA.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-B.bed -wa -u >Bcell_RA.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_RA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-B.bed  -wa -u >Bcell_RA.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-B.bed -wa -u >Bcell_SLE.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-B.bed -wa -u >Bcell_SLE.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-B.bed -wa -u >Bcell_SLE.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Bcell_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-B.bed  -wa -u >Bcell_SLE.celfie_sites.bed

####T cell
cd /home/yjq/450k/every_cell_type/tcell/
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_CD.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD8T_CD.statistic.bed > PB_Tcell_CD.bed
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_GD.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD8T_GD.statistic.bed >PB_Tcell_GD.bed
cat /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_UC.statistic.bed /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD8T_UC.statistic.bed>PB_Tcell_UC.bed

cd /home/yjq/450k/new/every_cell_type/
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_CD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_CD.celfeer_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_CD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_CD.celfeer_sites.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_CD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_CD.celfie_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_CD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_CD.celfie_sites.bed

bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_GD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_GD.celfeer_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_GD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_GD.celfeer_sites.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_GD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_GD.celfie_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_GD.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_GD.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_JIA.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_JIA.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_JIA.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_JIA.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_SLE.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_SLE.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_SLE.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_SLE.celfie_sites.bed

bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_UC.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_UC.celfeer_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_UC.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_UC.celfeer_sites.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_UC.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_UC.celfie_region.bed
bedtools intersect -a /home/yjq/450k/every_cell_type/tcell/PB_Tcell_UC.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_UC.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_cSCC.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_cSCC.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_cSCC.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_cSCC.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_kidneytransplantcSCC.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_kidneytransplantcSCC.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_kidneytransplantcSCC.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_kidneytransplantcSCC.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_kidneytransplant.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_kidneytransplant.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_kidneytransplant.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_kidneytransplant.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-T.bed -wa -u >Tcell_LIHC.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-T.bed -wa -u >Tcell_LIHC.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-T.bed -wa -u >Tcell_LIHC.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-T.bed  -wa -u >Tcell_LIHC.celfie_sites.bed

cd /home/yjq/450k/every_cell_type/tcell/

bedtools intersect -a PB_Tcell_CD.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_CD.ma.bed
bedtools intersect -a PB_Tcell_CD.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_CD.uxm.bed

bedtools intersect -a PB_Tcell_GD.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_GD.ma.bed
bedtools intersect -a PB_Tcell_GD.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_GD.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_JIA.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_JIA.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_JIA.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_SLE.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_CD4T_SLE.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_SLE.uxm.bed

bedtools intersect -a PB_Tcell_UC.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_UC.ma.bed
bedtools intersect -a PB_Tcell_UC.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_UC.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_cSCC.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_cSCC.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_cSCC.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_kidneytransplantcSCC.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplantcSCC.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_kidneytransplantcSCC.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_kidneytransplant.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_kidneytransplant.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_kidneytransplant.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-T.bed -wa -u >Tcell_LIHC.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_Tcell_LIHC.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-T.bed  -wa -u >Tcell_LIHC.uxm.bed

####monocyte
cd /home/yjq/450k/new/every_cell_type/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_CD.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_CD.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_CD.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_CD.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_MG.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_MG.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_MG.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_MG.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_MS.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_MS.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_MS.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_MS.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_SLE.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_SLE.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_SLE.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_SLE.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.celfie_sites.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_UC.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_UC.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Mono+Macro.bed -wa -u >monocyte_UC.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Mono+Macro.bed -wa -u >monocyte_UC.celfie_sites.bed

cd /home/yjq/450k/every_cell_type/monocyte/

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_CD.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_CD.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_CD.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_HIVpos.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_HIVpos.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_MG.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MG.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_MG.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_MS.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_MS.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_MS.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_SLE.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_SLE.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_SLE.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_tuberculosis.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_tuberculosis.uxm.bed

bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Mono+Macro.bed -wa -u >monocyte_UC.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_monocyte_UC.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Mono+Macro.bed -wa -u >monocyte_UC.uxm.bed

####granulocyte
cd /home/yjq/450k/every_cell_type/granulocyte/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/meth_atlas_ref/Blood-Granul.bed -wa -u >Granul_SLE.ma.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/yjq/UXM_deconv/UXM/filter_15_markers/Markers.Blood-Granul.bed -wa -u >Granul_SLE.uxm.bed

cd /home/yjq/450k/new/every_cell_type/
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/region/Blood-Granul.bed -wa -u >Granul_SLE.celfeer_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfeer_ref/cpg_sites/Blood-Granul.bed -wa -u >Granul_SLE.celfeer_sites.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/region/Blood-Granul.bed -wa -u >Granul_SLE.celfie_region.bed
bedtools intersect -a /home/sty/cfDNA_benchmark/statistic_data/450k/PB_granulocyte_SLE.statistic.bed -b /home/sty/cfDNA_benchmark/statistic_data/celfie_ref/cpg_sites/Blood-Granul.bed -wa -u >Granul_SLE.celfie_sites.bed