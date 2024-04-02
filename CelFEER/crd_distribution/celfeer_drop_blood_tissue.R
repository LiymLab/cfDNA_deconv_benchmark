data_full <- read.table('~/celfeer_work2/median_depth_filter/median_15/full_data_input_median_15.txt',skip = 1)
colnames_all <- strsplit(readLines('~/celfeer_work2/median_depth_filter/median_15/full_data_input_median_15.txt',n=1),split = '\t')[[1]]     #记录列名信息
colnames_tissue <- colnames_all[107:141]     #从列名信息中挑选tissue的列名
tissue_drop <- c('Blood-NK','Blood-Granul','Blood-Mono+Macro','Blood-B','Blood-T')
tissues_drop <- list(c('Blood-NK','Lung-Ep-Alveo'),c('Blood-Granul','Colon-Fibro'),c('Blood-Mono+Macro','Bladder-Ep'),
                     c('Blood-B','Oligodend'),c('Blood-T','Skeletal-Musc'))

#drop one blood cell type
for(i in tissue_drop){
  start <- 506 + 5 * grep(i,colnames_tissue,fixed = TRUE) - 4     #记录选择的tissue的数据的起始索引位置
  end <- start + 4     #记录选择的tissue的数据的终止索引位置
  data_drop <- data_full[,-(start:end)]     #删除对应tissue的所有数据
  data_name <- paste0('~/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/data_input.txt')
  colnames_drop <- t(as.data.frame(colnames_all[-grep(i,colnames_all,fixed = TRUE)]))     #去除对应的tissue的colname并形成一个新的colnames
  col_name <- paste0('~/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/colnames.txt')
  write.table(data_drop,file = data_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}

#drop two blood cell types
for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  tissue1_start <- 506 + 5 * grep(tissue1,colnames_tissue,fixed = TRUE) - 4
  tissue1_end <- tissue1_start + 4
  colnames_tissue <- colnames_tissue[-grep(tissue1,colnames_tissue,fixed = TRUE)]
  tissue2_start <- 506 + 5 * grep(tissue2,colnames_tissue,fixed = TRUE) - 4
  tissue2_end <- tissue2_start + 4
  data_drop <- data_full[,-(tissue1_start:tissue1_end)]
  data_drop <- data_drop[,-(tissue2_start:tissue2_end)]     #依次删除一组tissue中的所有tissue的数据
  colnames_drop <- colnames_all[-grep(tissue1,colnames_all,fixed = TRUE)]
  colnames_drop <- t(as.data.frame(colnames_drop[-grep(tissue2,colnames_drop,fixed = TRUE)]))     #依次删除一组tissue中的所有列名信息
  col_name <- paste0('~/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_',tissue1,'_',tissue2,'/colnames.txt')
  data_name <- paste0('~/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_',tissue1,'_',tissue2,'/data_input.txt')
  write.table(data_drop,file = data_name,sep = '\t',col.names = FALSE,row.names = FALSE,quote = FALSE)
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}
