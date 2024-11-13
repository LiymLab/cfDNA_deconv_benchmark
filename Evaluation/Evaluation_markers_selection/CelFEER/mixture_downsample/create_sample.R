library(data.table)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
distribution <- args[1]
coverage <- args[2]

file_path <- '/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/downsample_onehot/'
if(distribution=='uniform'){
  file_names <- list.files(paste0(file_path,'uniform_',coverage))
}else if(distribution=='crd'){
  file_names <- list.files(paste0(file_path,'crd_',coverage))    
}else if(distribution=='dirichlet'){
  file_names <- list.files(paste0(file_path,'dirichlet_',coverage))
}else{
  file_path <- paste0(file_path,'dirichlet_0.5/dirichlet_')
  file_names <- list.files(paste0(file_path,'dirichlet_0.5/dirichlet_',coverage))
} # modify this part according to actual situation

bin_res <- fread('/home/zyc/celfeer_sample_ds/intersect_res.bed')
bin_index <- bin_res[,-c(4:6)]
colnames(bin_index) <- c('chrom','start','end','index')

for (i in 1:length(file_names)){
  file_name <- paste0(file_path,coverage,'/',file_names[i])
  sample_onehot <- fread(file_name,skip = 1)
  colnames(sample_onehot) <- c('index','one','two','three','four','five')
  sample_onehot <- sample_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index]
  data <- left_join(bin_index,sample_onehot,by = 'index')
  data[is.na(data)] <- 0
  data_res <- data[,.(sum(V1),sum(V2),sum(V3),sum(V4),sum(V5)),by=.(chrom,start,end)]
  data_res <- data_res[,c(4:8)]
  write_name <- paste0('/home/zyc/celfeer_sample_ds/celfeer_sample_ds_',coverage,'/',distribution,'/sample_data/','sample_',i,'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}