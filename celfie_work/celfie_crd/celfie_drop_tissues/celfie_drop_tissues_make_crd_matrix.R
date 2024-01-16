crd_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/crd_dis/crd_dis.csv')
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  crd_matrix_drop <-  crd_matrix[-which(crd_matrix$ID == tissue1),]
  crd_matrix_drop <-  crd_matrix_drop[-which(crd_matrix_drop$ID == tissue2),]     #分别删除一组cell type对应的索引的数据
  data_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/crd_matrix.csv')
  write.table(crd_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}