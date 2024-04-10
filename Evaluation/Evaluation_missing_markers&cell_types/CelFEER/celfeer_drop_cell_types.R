data_full <- read.table('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/median_depth_filter/median_15/full_data_input_median_15.txt',skip = 1) # complete file to be possessed; modify it according to your actual demands
colnames_all <- strsplit(readLines('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/median_depth_filter/median_15/full_data_input_median_15.txt',n=1),split = '\t')[[1]]
colnames_tissue <- colnames_all[107:141]
tissue_drop <- c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep') # selected cell type; modify it according to your actual demands
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro')) # selected cell types; modify it according to your actual demands
# tissue_drop <- c('Blood-NK','Blood-Granul','Blood-Mono+Macro','Blood-B','Blood-T')
# tissues_drop <- list(c('Blood-NK','Lung-Ep-Alveo'),c('Blood-Granul','Colon-Fibro'),c('Blood-Mono+Macro','Bladder-Ep'),
#                      c('Blood-B','Oligodend'),c('Blood-T','Skeletal-Musc'))

# drop one cell type
for(i in tissue_drop){
  start <- 506 + 5 * grep(i,colnames_tissue) - 4
  end <- start + 4
  data_drop <- data_full[,-(start:end)]
  data_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/data_input.txt') # modify the path according to your actual situation
  colnames_drop <- t(as.data.frame(colnames_all[-grep(i,colnames_all)]))
  col_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/colnames.txt') # modify the path according to your actual situation
  write.table(data_drop,file = data_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}

# drop two cell types
for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  tissue1_start <- 506 + 5 * grep(tissue1,colnames_tissue,fixed = TRUE) - 4
  tissue1_end <- tissue1_start + 4
  colnames_tissue <- colnames_tissue[-grep(tissue1,colnames_tissue,fixed = TRUE)]
  tissue2_start <- 506 + 5 * grep(tissue2,colnames_tissue,fixed = TRUE) - 4
  tissue2_end <- tissue2_start + 4
  data_drop <- data_full[,-(tissue1_start:tissue1_end)]
  data_drop <- data_drop[,-(tissue2_start:tissue2_end)]
  colnames_drop <- colnames_all[-grep(tissue1,colnames_all,fixed = TRUE)]
  colnames_drop <- t(as.data.frame(colnames_drop[-grep(tissue2,colnames_drop,fixed = TRUE)]))
  col_name <- paste0('~/celfeer_work1/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/colnames.txt') # modify the path according to your actual situation
  data_name <- paste0('~/celfeer_work1/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/data_input.txt') # modify the path according to your actual situation
  write.table(data_drop,file = data_name,sep = '\t',col.names = FALSE,row.names = FALSE,quote = FALSE)
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}
