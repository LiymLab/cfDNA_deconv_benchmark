data_full <- read.table('~/celfeer_work2/median_depth_filter/median_15/full_data_input_median_15.txt',skip = 1)
colnames_all <- strsplit(readLines('~/celfeer_work2/median_depth_filter/median_15/full_data_input_median_15.txt',n=1),split = '\t')[[1]]     #记录列名信息
colnames_tissue <- colnames_all[107:141]     #从列名信息中挑选tissue的列名

for(i in c('Blood-NK','Blood-Granul','Blood-Mono+Macro','Blood-B','Blood-T')){
  start <- 506 + 5 * grep(i,colnames_tissue,fixed = TRUE) - 4     #记录选择的tissue的数据的起始索引位置
  end <- start + 4     #记录选择的tissue的数据的终止索引位置
  data_drop <- data_full[,-(start:end)]     #删除对应tissue的所有数据
  data_name <- paste0('~/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/data_input.txt')
  colnames_drop <- t(as.data.frame(colnames_all[-grep(i,colnames_all,fixed = TRUE)]))     #去除对应的tissue的colname并形成一个新的colnames
  col_name <- paste0('~/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/colnames.txt')
  write.table(data_drop,file = data_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}
