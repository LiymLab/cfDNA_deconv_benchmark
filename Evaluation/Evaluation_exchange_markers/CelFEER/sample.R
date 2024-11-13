library(data.table)
library(dplyr)

args <- commandArgs(trailingOnly = TRUE)
distribution <- args[1]

if(distribution=='uniform'){
  file_path <- '/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/uniform_mix/' # path storing sample data; change the path according to your actual situation
  file_names <- list.files(file_path)
}else if(distribution=='crd'){
  file_path <- '/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/crd_mix/' # path storing sample data; change the path according to your actual situation
  file_names <- list.files(file_path)    
  which_100 <- which(file_names == "crd_dis_100_1_onehot_records.tsv")
  file_names <- c(file_names,file_names[which_100])
  file_names <- file_names[-which_100]
}else{
  file_path <- '/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/dirichlet_mix/' # path storing sample data; change the path according to your actual situation
  file_names <- list.files(file_path)
  which_100 <- which(file_names == "dirichlet_100_1_onehot_records.tsv")
  file_names <- c(file_names,file_names[which_100])
  file_names <- file_names[-which_100]
} # modify this part according to actual situation

# for markers of uxm/celfie:
bin_res <- fread('/bedtools_res_median_15.bed')
bin_index <- bin_res[,-c(4:6)]
colnames(bin_index) <- c('chrom','start','end','index')
# regions <- unique(bin_res[,1:3])
# write.table(regions,file = '~/celfeer_work1/regions.txt',row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')

for (i in 1:length(file_names)){
  file_name <- paste0(file_path,file_names[i])
  sample_onehot <- fread(file_name,skip = 1)
  colnames(sample_onehot) <- c('index','one','two','three','four','five')
  sample_onehot <- sample_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index] 
  data <- left_join(bin_index,sample_onehot,by = 'index',all.x = TRUE)
  data[is.na(data)] <- 0
  data_res <- data[,.(sum(V1),sum(V2),sum(V3),sum(V4),sum(V5)),by=.(chrom,start,end)] 
  data_res <- data_res[,c(4:8)]
  write_name <- paste0('/',distribution,'/sample_data/','sample_',i,'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}

# for markers of cfnome/methatlas:
bin_index <- fread('/cfnome_markers.bed')
colnames(bin_index) <- c('chrom','start','end','index')

for (i in 1:length(file_names)){
  file_name <- paste0(file_path,file_names[i])
  sample_onehot <- fread(file_name,skip = 1)
  colnames(sample_onehot) <- c('index','one','two','three','four','five')
  sample_onehot <- sample_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index] 
  data <- merge(bin_index,sample_onehot,by = 'index',all.x = TRUE)
  data[is.na(data)] <- 0
  data_res <- data[,c(5:9)]
  write_name <- paste0('/home/zyc/celfeer_exchange_markers/celfeer_markers-of-cfnome/',distribution,'/sample_data/','sample_',i,'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}
