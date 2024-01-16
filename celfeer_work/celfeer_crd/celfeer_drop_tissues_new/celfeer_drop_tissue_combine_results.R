pearson_result <- data.frame(matrix(nrow = 100,ncol = 0))
rmse_result <- data.frame(matrix(nrow = 100,ncol = 0))
colnames <- c()
tissues_drop <- list(c('Blood-NK','Lung-Ep-Alveo'),c('Blood-Granul','Colon-Fibro'),c('Blood-Mono+Macro','Bladder-Ep'),
                     c('Blood-B','Oligodend'),c('Blood-T','Skeletal-Musc'))

for(i in c('Blood-NK','Blood-Granul','Blood-Mono+Macro','Blood-B','Blood-T')){
  pearson_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/pearson_result_drop_',i,'.csv')
  rmse_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissue_new/data_median_15_drop_',i,'/rmse_result_drop_',i,'.csv')
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
  pearson_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_',tissue1,'_',tissue2,'/pearson_result_drop_',tissue1,'_',tissue2,'.csv')
  rmse_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_tissues_new/data_median_15_drop_',tissue1,'_',tissue2,'/rmse_result_drop_',tissue1,'_',tissue2,'.csv')
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
write.table(rmse_results,file = '/home/zyc/celfeer_work2/celfeer_drop_tissue_new/celfeer_crd_drop_cell_type_rmse_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
write.table(pearson_results,file = '/home/zyc/celfeer_work2/celfeer_drop_tissue_new/celfeer_crd_drop_cell_type_pearson_results.csv',sep = ',',quote = FALSE,col.names = TRUE,row.names = FALSE)
