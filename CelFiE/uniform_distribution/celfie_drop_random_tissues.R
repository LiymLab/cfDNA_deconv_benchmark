#用list存放五组cell type信息
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))
data_full <- read.table('~/celfie_work2/median_depth_filter/median_15/data_input_median_15.txt',header = TRUE,check.names = FALSE)

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  tissue1_meth <- paste0(tissue1,'_METH')
  tissue1_depth <- paste0(tissue1,'_DEPTH')
  tissue2_meth <- paste0(tissue2,'_METH')
  tissue2_depth <- paste0(tissue2,'_DEPTH')
  data_drop <- data_full[,-grep(tissue1_meth,colnames(data_full),fixed = TRUE)]
  data_drop <- data_drop[,-grep(tissue1_depth,colnames(data_drop),fixed = TRUE)]
  data_drop <- data_drop[,-grep(tissue2_meth,colnames(data_drop),fixed = TRUE)]     #依次去除每组cell type的meth信息对应的索引的数据
  data_drop <- data_drop[,-grep(tissue2_depth,colnames(data_drop),fixed = TRUE)]     #依次去除每组cell type的depth信息对应的索引的数据
  colnames(data_drop)[204:206] <- c('CHROM','METH','DEPTH')
  data_name <- paste0('~/celfie_work1/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/data_input.txt')
  write.table(data_drop,file = data_name,sep = '\t',col.names = TRUE,row.names = FALSE,quote = FALSE)
}