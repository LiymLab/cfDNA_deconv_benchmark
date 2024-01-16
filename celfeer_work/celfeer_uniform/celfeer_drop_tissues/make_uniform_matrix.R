uniform_matrix <- read.csv('/home/sty/cfDNA_benchmark/benchmark_pat/uniform_dis/uniform_matrix_d.csv')
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  uniform_matrix_drop <-  uniform_matrix[-which(uniform_matrix$ID == tissue1),]
  uniform_matrix_drop <-  uniform_matrix_drop[-which(uniform_matrix_drop$ID == tissue2),]
  data_name <- paste0('~/celfeer_work1/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/uniform_matrix.csv')
  write.table(uniform_matrix_drop,file = data_name,quote = FALSE,col.names = TRUE,row.names = FALSE,sep = ',')
}