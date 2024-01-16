library(data.table)

args <- commandArgs(trailingOnly = TRUE)     #接收参数
input_data <- args[1]
output_position <- args[2]

data_full <- fread(input_data,header = TRUE,sep = '\t')
markers_num <- nrow(data_full)     #计算markers总数

for (i in c(0.1,0.2,0.3,0.4,0.5)){
  for (j in 1:20){
    drop_num <- trunc(markers_num*i)     #计算得到需要drop的markers的数目
    drop_index <- sample(1:markers_num,drop_num,replace = FALSE)     #随机生成对应需要drop的markers的数目的索引
    data_drop_res <- data_full[-drop_index,]     #去除选择的索引的数据
    file_name <- paste0('~/celfie_work2/celfie_drop_markers/',output_position,'/',output_position,'_drop_',i,'_',j,'/data_',output_position,'_drop_',i,'_',j,'.txt')
    write.table(data_drop_res,file = file_name,col.names = TRUE,row.names = FALSE,quote = FALSE,sep = '\t')
  }
}