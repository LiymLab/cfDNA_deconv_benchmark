crd_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/crd_dis/crd_dis.csv')
#采用list存放五组cell type的信息
tissues_drop <- list(c('Blood-NK','Lung-Ep-Alveo'),c('Blood-Granul','Colon-Fibro'),c('Blood-Mono+Macro','Bladder-Ep'),
                     c('Blood-B','Oligodend'),c('Blood-T','Skeletal-Musc'))

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  crd_matrix_drop <-  crd_matrix[-which(crd_matrix$ID == tissue1),]
  crd_matrix_drop <-  crd_matrix_drop[-which(crd_matrix_drop$ID == tissue2),]     #分别删除一组cell type对应的索引的数据
  data_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_',tissue1,'_',tissue2,'/crd_matrix.csv')
  write.table(crd_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}