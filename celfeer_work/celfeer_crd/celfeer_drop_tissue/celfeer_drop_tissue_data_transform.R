library(data.table)

#采用循环，依次从完整结果文件中去除unknown数据并转换成比较所需的数据框形式
for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  read_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissue/data_median_15_drop_',i,'/data_median_15_drop_',i,'_output/1_tissue_proportions.txt')
  tissue_proportions <- fread(read_name,header = FALSE,check.names = FALSE)
  tissue_proportions[1,1] <- 'ID'
  t_tissue_proportions <- t(tissue_proportions[,ncol(tissue_proportions) := NULL])     #采用data.table中去除最后一列的方法删除结果文件中的unknown数据，并转置数据得到比较所需形式
  output_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissue/data_median_15_drop_',i,'/t_tissue_proportions.csv')
  write.table(t_tissue_proportions,file = output_name,sep = ',',quote = FALSE,col.names = FALSE,row.names = FALSE)
}
