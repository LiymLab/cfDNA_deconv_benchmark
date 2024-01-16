library(data.table)

setwd('/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/uniform_mix')
file_names <- list.files()
bin_res <- fread('/home/zyc/celfeer_work1/500_bin_res.bed')
bin_index <- bin_res[,-c(4:6)]
colnames(bin_index) <- c('chrom','start','end','index')
# regions <- unique(bin_res[,1:3])
# write.table(regions,file = '~/celfeer_work1/regions.txt',row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')

for (i in 1:length(file_names)){
  file_name <- file_names[i]
  sample_onehot <- fread(file_name,skip = 1)
  colnames(sample_onehot) <- c('index','one','two','three','four','five')
  sample_onehot <- sample_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index]
  data <- merge(bin_index,sample_onehot,by = 'index',all.x = TRUE)
  data[is.na(data)] <- 0
  data_res <- data[,.(sum(V1),sum(V2),sum(V3),sum(V4),sum(V5)),by=.(chrom,start,end)]
  data_res <- data_res[,c(4:8)]
  write_name <- paste0('~/celfeer_work1/sample_data/','sample_',i,'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}