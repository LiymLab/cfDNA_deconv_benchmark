library(data.table)

setwd('/home/sty/cfDNA_benchmark/celfeer_data/true_onehot/crd_mix')
file_names <- list.files()     #记录文件信息
which_100 <- which(file_names == "crd_dis_100_1_onehot_records.tsv")
file_names <- c(file_names,file_names[which_100])
file_names <- file_names[-which_100]     #调整文件信息，使之为1-100的顺序，方便后续操作
bin_res <- fread('/home/zyc/celfeer_work1/500_bin_res.bed')
bin_index <- bin_res[,-c(4:6)]     #获取500 bin的regions对应的索引信息
colnames(bin_index) <- c('chrom','start','end','index')
# regions <- unique(bin_res[,1:3])
# write.table(regions,file = '~/celfeer_work1/regions.txt',row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')

for (i in 1:length(file_names)){
  file_name <- file_names[i]
  sample_onehot <- fread(file_name,skip = 1)
  colnames(sample_onehot) <- c('index','one','two','three','four','five')
  sample_onehot <- sample_onehot[,.(sum(one),sum(two),sum(three),sum(four),sum(five)),by=index]     #将onehot数据按索引加和在一起
  data <- merge(bin_index,sample_onehot,by = 'index',all.x = TRUE)     #将500 bin信息与上一步中得到的数据merge
  data[is.na(data)] <- 0     #将merge结果中的NA值填充为0
  data_res <- data[,.(sum(V1),sum(V2),sum(V3),sum(V4),sum(V5)),by=.(chrom,start,end)]     #按500 bin的regions信息加和数据
  data_res <- data_res[,c(4:8)]
  write_name <- paste0('~/celfeer_work2/sample_data/','sample_',i,'_data.txt')
  write.table(data_res,file = write_name,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
}