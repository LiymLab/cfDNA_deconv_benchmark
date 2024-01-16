crd_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/crd_dis/crd_dis.csv')

#采用循环依次从完整的分布数据中去除对应tissue的数据信息得到比较所需的数据
for(i in c('Blood-NK','Blood-Granul','Blood-Mono+Macro','Blood-B','Blood-T')){
  crd_matrix_drop <-  crd_matrix[-which(crd_matrix$ID == i),]     #删除对应tissue的索引的数据
  data_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/crd_matrix.csv')
  write.table(crd_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}
