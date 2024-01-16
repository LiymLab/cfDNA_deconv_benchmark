library(data.table)

for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  read_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/data_median_15_drop_',i,'_output/1_tissue_proportions.txt')
  tissue_proportions <- fread(read_name,header = FALSE,check.names = FALSE)
  tissue_proportions[1,1] <- 'ID'
  t_tissue_proportions <- t(tissue_proportions[,ncol(tissue_proportions) := NULL])
  output_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/t_tissue_proportions.csv')
  write.table(t_tissue_proportions,file = output_name,sep = ',',quote = FALSE,col.names = FALSE,row.names = FALSE)
}
