data_full <- read.table('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/median_depth_filter/median_15/full_data_input_median_15.txt',skip = 1)
colnames_all <- strsplit(readLines('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/median_depth_filter/median_15/full_data_input_median_15.txt',n=1),split = '\t')[[1]]
colnames_tissue <- colnames_all[107:141]

for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  start <- 506 + 5 * grep(i,colnames_tissue) - 4
  end <- start + 4
  data_drop <- data_full[,-(start:end)]
  #data_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/data_input.txt')
  data_name <- paste0('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/data_input.txt')
  colnames_drop <- t(as.data.frame(colnames_all[-grep(i,colnames_all)]))
  col_name <- paste0('/dfs5/weil21-lab/yumeil1/tmp/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/colnames.txt')
  #col_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/colnames.txt')
  write.table(data_drop,file = data_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
  write.table(colnames_drop,file = col_name,col.names = FALSE,row.names = FALSE,sep = '\t',quote = FALSE)
}
