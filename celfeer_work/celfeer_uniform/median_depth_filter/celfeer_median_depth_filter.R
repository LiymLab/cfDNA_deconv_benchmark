pearson_results <- data.frame(matrix(nrow = 100,ncol = 0))     #创建空数据框用于拼接数据
rmse_results <- data.frame(matrix(nrow = 100,ncol = 0))
colnames <- c()     #创建空向量用于拼接列名

#循环读入不同median depth filter下的rmse和pearson结果，依次以cbind方法拼接起来，在此过程中记录对应列名
for(i in c(15,20,25,30,35,40,45,50,60,70,80,90,100)){
  pearson_result_name <- paste0('/home/zyc/celfeer_work1/median_depth_filter/median_',i,'/pearson_result_median_',i,'.csv')
  rmse_result_name <- paste0('/home/zyc/celfeer_work1/median_depth_filter/median_',i,'/rmse_result_median_',i,'.csv')
  pearson_result <- read.table(pearson_result_name,header = TRUE,sep = ',')
  rmse_result <- read.table(rmse_result_name,header = TRUE,sep = ',')
  pearson_results <- cbind(pearson_results,pearson_result)
  rmse_results <- cbind(rmse_results,rmse_result)
  colname <- paste0('median_depth_filter_',i)     #记录列名
  colnames <- c(colnames,colname)
}
pearson_results <- pearson_results[,seq(0,ncol(pearson_results),2)]     #提取偶数列
rmse_results <- rmse_results[,seq(0,ncol(rmse_results),2)]
colnames(pearson_results) <- colnames     #赋予数据对应列名
colnames(rmse_results) <- colnames
pearson_results_name <- '/home/zyc/celfeer_work1/median_depth_filter/celfeer_uniform_pearson_res_combined.csv'
rmse_results_name <- '/home/zyc/celfeer_work1/median_depth_filter/celfeer_uniform_rmse_res_combined.csv'
write.table(pearson_results,file = pearson_results_name,sep = ',',row.names = FALSE,col.names = TRUE,quote = FALSE)
write.table(rmse_results,file = rmse_results_name,sep = ',',row.names = FALSE,col.names = TRUE,quote = FALSE)