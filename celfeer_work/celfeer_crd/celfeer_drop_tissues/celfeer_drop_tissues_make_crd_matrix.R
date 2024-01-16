cfsort_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/cfsort_dis/cfsort_dis.csv')
#采用list存放五组cell type的信息
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  cfsort_matrix_drop <-  cfsort_matrix[-which(cfsort_matrix$ID == tissue1),]
  cfsort_matrix_drop <-  cfsort_matrix_drop[-which(cfsort_matrix_drop$ID == tissue2),]     #分别删除一组cell type对应的索引的数据
  data_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/cfsort_matrix.csv')
  write.table(cfsort_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}