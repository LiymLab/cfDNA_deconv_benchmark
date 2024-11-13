library(data.table)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
file_path <- args[1]
output <- args[2]

file_names <- list.files(file_path)
tissues <- sapply(strsplit(file_names,'\\_'),'[',1)
bin_res <- fread('/home/zyc/celfeer_work1/500_bin_res.bed')
bin_index <- bin_res[,-c(4:6)]
colnames(bin_index) <- c('chrom','start','end','index')
# regions <- unique(bin_res[,1:3])
# write.table(regions,file = '~/celfeer_work1/regions.txt',row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')

for (i in 1:length(file_names)){
  file_name <- file_names[i]
  file_name <- paste0(file_path,'/',file_name)
  tissue_onehot <- fread(file_name,skip = 1)
  colnames(tissue_onehot) <- c('index','one','two','three','four','five')
  tissue_onehot <- tissue_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index]
  data <- left_join(bin_index,tissue_onehot,by = 'index',all.x = TRUE)
  data[is.na(data)] <- 0
  data_res <- data[,.(sum(V1),sum(V2),sum(V3),sum(V4),sum(V5)),by=.(chrom,start,end)]
  data_res <- data_res[,c(4:8)]
  write_name <- paste0(output,'/',tissues[i],'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}
