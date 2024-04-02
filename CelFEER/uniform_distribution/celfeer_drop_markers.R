library(data.table)

args <- commandArgs(trailingOnly = TRUE)
input_data <- args[1]
output_position <- args[2]

data_full <- fread(input_data,sep = '\t',skip = 1,header = FALSE)
markers_num <- nrow(data_full)

for (i in c(0.1,0.2,0.3,0.4,0.5)){
  for (j in 1:20){
    drop_num <- trunc(markers_num*i)
    drop_index <- sample(1:markers_num,drop_num,replace = FALSE)
    data_drop_res <- data_full[-drop_index,]
	  file_name <- paste0('~/celfeer_work1/celfeer_drop_markers/',output_position,'/',output_position,'_drop_',i,'_',j,'/data_',output_position,'_drop_',i,'_',j,'.txt')
    write.table(data_drop_res,file = file_name,col.names = FALSE,row.names = FALSE,quote = FALSE,sep = '\t')
  }
}
