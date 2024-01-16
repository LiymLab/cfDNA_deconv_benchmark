pearson_result <- data.frame(matrix(nrow = 100,ncol = 0))     #创建空数据框用于拼接数据
rmse_result <- data.frame(matrix(nrow = 100,ncol = 0))
colnames <- c()     #创建空向量用于拼接列名
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

#循环读入对应去除cell type的结果文件并将其拼接起来
for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  pearson_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissue/data_median_15_drop_',i,'/pearson_result_drop_',i,'.csv')
  rmse_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissue/data_median_15_drop_',i,'/rmse_result_drop_',i,'.csv')
  colname <- paste0('drop_',i)     #记录列名
  pearson <- read.csv(pearson_name)
  rmse <- read.csv(rmse_name)
  pearson_result <- cbind(pearson_result,pearson)
  rmse_result <- cbind(rmse_result,rmse)
  colnames <- c(colnames,colname)
}

#循环读入对应去除一组cell type的结果文件并将其拼接起来
for(j in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[j]][1]
  tissue2 <- tissues_drop[[j]][2]
  pearson_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/pearson_result_drop_',tissue1,'_',tissue2,'.csv')
  rmse_name <- paste0('/home/zyc/celfie_work2/celfie_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/rmse_result_drop_',tissue1,'_',tissue2,'.csv')
  colname <- paste0('drop_',tissue1,'_',tissue2)
  pearson <- read.csv(pearson_name)
  rmse <- read.csv(rmse_name)
  pearson_result <- cbind(pearson_result,pearson)
  rmse_result <- cbind(rmse_result,rmse)
  colnames <- c(colnames,colname)
}

pearson_results <- pearson_result[,seq(0,ncol(pearson_result),2)]     #提取偶数列
colnames(pearson_results) <- colnames
rmse_results <- rmse_result[,seq(0,ncol(pearson_result),2)]
colnames(rmse_results) <- colnames     #赋予数据对应列名
write.table(rmse_results,file = '/home/zyc/celfie_work2/celfie_drop_tissue/celfie_crd_drop_cell_type_rmse_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
write.table(pearson_results,file = '/home/zyc/celfie_work2/celfie_drop_tissue/celfie_crd_drop_cell_type_pearson_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
