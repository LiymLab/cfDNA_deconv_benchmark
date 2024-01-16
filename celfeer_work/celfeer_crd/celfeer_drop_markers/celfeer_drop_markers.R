pearson_results_final <- data.frame(matrix(nrow = 100,ncol = 0))     #创建空数据框用于拼接数据
rmse_results_final <- data.frame(matrix(nrow = 100,ncol = 0))
colnames <- c()     #创建空向量用于拼接列名

#循环依次读入不同median depth filter下不同比例的丢失的不同重复次数的结果文件，将重复次数的20个文件取均值作为一列数据拼接到最终数据中
for(i in c(15,20,25,30,35,40,45,50,60,70,80,90,100)){
  pearson_results_progress <- data.frame(matrix(nrow = 100,ncol = 0))     #创建空数据框用于存放循环过程中计算得到的20次重复的均值的数据
  rmse_results_progress <- data.frame(matrix(nrow = 100,ncol = 0))
  for(j in c(0.1,0.2,0.3,0.4,0.5)){
    pearson_results_initial <- data.frame(matrix(nrow = 100,ncol = 0))     #创建空数据框用于存放20次重复的结果数据
    rmse_results_initial <- data.frame(matrix(nrow = 100,ncol = 0))
    for(k in 1:20){
      pearson_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_markers/median_',i,'/median_',i,'_drop_',j,'_',k,'/pearson_result_median_',i,'_drop_',j,'_',k,'.csv')
      rmse_name <- paste0('/home/zyc/celfeer_work2/celfeer_drop_markers/median_',i,'/median_',i,'_drop_',j,'_',k,'/rmse_result_median_',i,'_drop_',j,'_',k,'.csv')
      pearson_result <- read.table(pearson_name,sep = ',',header = TRUE)
      rmse_result <- read.table(rmse_name,sep = ',',header = TRUE)
      pearson_results_initial <- cbind(pearson_results_initial,pearson_result)
      rmse_results_initial <- cbind(rmse_results_initial,rmse_result)
    }
    pearson_results_initial <- pearson_results_initial[,seq(0,ncol(pearson_results_initial),2)]     #提取偶数列
    rmse_results_initial <- rmse_results_initial[,seq(0,ncol(rmse_results_initial),2)]
    colname <- paste0('median_',i,'_drop_',j)     #记录对应列名
    colnames <- c(colnames,colname)
    pearson_mean <- rowMeans(pearson_results_initial)     #使用rowMeans方法计算20次重复的均值
    rmse_mean <- rowMeans(rmse_results_initial)
    pearson_results_progress <- cbind(pearson_results_progress,pearson_mean)
    rmse_results_progress <- cbind(rmse_results_progress,rmse_mean)
  }
  pearson_results_final <- cbind(pearson_results_final,pearson_results_progress)
  rmse_results_final <- cbind(rmse_results_final,rmse_results_progress)
}
colnames(pearson_results_final) <- colnames
colnames(rmse_results_final) <- colnames
write.table(pearson_results_final,file = '/home/zyc/celfeer_work2/celfeer_drop_markers/celfeer_cfsort_drop_markers_pearson_results_combined.csv',row.names = FALSE,col.names = TRUE,quote = FALSE,sep = ',')
write.table(rmse_results_final,file = '/home/zyc/celfeer_work2/celfeer_drop_markers/celfeer_cfsort_drop_markers_rmse_results_combined.csv',row.names = FALSE,col.names = TRUE,quote = FALSE,sep = ',')
