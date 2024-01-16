uniform_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv')

for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  uniform_matrix_drop <-  uniform_matrix[-which(uniform_matrix$ID == i),]
  data_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/uniform_matrix.csv')
  write.table(uniform_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}
