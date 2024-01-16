pearson_result <- data.frame(matrix(nrow = 100,ncol = 0))
rmse_result <- data.frame(matrix(nrow = 100,ncol = 0))
colnames <- c()
tissues_drop <- list(c('Pancreas-Duct','Blood-Granul'),c('Fallopian-Ep','Eryth-prog'),c('Blood-Mono+Macro','Lung-Ep-Alveo'),
                     c('Thyroid-Ep','Colon-Fibro'),c('Head-Neck-Ep','Heart-Fibro'))

for(i in c('Endothelium','Blood-Granul','Adipocytes','Blood-NK','Head-Neck-Ep')){
  pearson_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/pearson_result_drop_',i,'.csv')
  rmse_name <- paste0('~/celfeer_work1/celfeer_drop_tissue/data_median_15_drop_',i,'/rmse_result_drop_',i,'.csv')
  colname <- paste0('drop_',i)
  pearson <- read.csv(pearson_name)
  rmse <- read.csv(rmse_name)
  pearson_result <- cbind(pearson_result,pearson)
  rmse_result <- cbind(rmse_result,rmse)
  colnames <- c(colnames,colname)
}

for(j in 1:length(tissues_drop)){
  tissue1 <- tissues_drop[[j]][1]
  tissue2 <- tissues_drop[[j]][2]
  pearson_name <- paste0('~/celfeer_work1/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/pearson_result_drop_',tissue1,'_',tissue2,'.csv')
  rmse_name <- paste0('~/celfeer_work1/celfeer_drop_tissues/data_median_15_drop_',tissue1,'_',tissue2,'/rmse_result_drop_',tissue1,'_',tissue2,'.csv')
  colname <- paste0('drop_',tissue1,'_',tissue2)
  pearson <- read.csv(pearson_name)
  rmse <- read.csv(rmse_name)
  pearson_result <- cbind(pearson_result,pearson)
  rmse_result <- cbind(rmse_result,rmse)
  colnames <- c(colnames,colname)
}

pearson_results <- pearson_result[,seq(0,ncol(pearson_result),2)]
colnames(pearson_results) <- colnames
rmse_results <- rmse_result[,seq(0,ncol(pearson_result),2)]
colnames(rmse_results) <- colnames
write.table(rmse_results,file = '~/celfeer_work1/celfeer_drop_tissue/celfeer_uniform_drop_cell_type_rmse_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
write.table(pearson_results,file = '~/celfeer_work1/celfeer_drop_tissue/celfeer_uniform_drop_cell_type_pearson_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
