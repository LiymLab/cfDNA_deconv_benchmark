library(data.table)

#采用list存放五组cell type的信息
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

for(i in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[i]][1]
  tissue2 <- tissues_drop[[i]][2]
  read_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/data_median_15_drop_',tissue1,'_',tissue2,'_output/1_tissue_proportions.txt')
  tissue_proportions <- fread(read_name,header = FALSE,check.names = FALSE)
  tissue_proportions[1,1] <- 'ID'
  tissue_proportions[,ncol(tissue_proportions) := NULL]
  t_tissue_proportions <- t(tissue_proportions[,ncol(tissue_proportions) := NULL])     #去除最后两列的unknown数据
  output_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/t_tissue_proportions.csv')
  write.table(t_tissue_proportions,file = output_name,sep = ',',quote = FALSE,col.names = FALSE,row.names = FALSE)
}