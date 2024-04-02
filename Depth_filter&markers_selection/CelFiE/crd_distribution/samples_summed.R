library(data.table)

#预处理，使用bedtools得到regions对应的cpgs点信息
#bedtools intersect -a tims_bed.bed -b bed.bed -wa -wb > bedtools_res_new.bed

args <- commandArgs(trailingOnly = TRUE)     #接收参数
input1 <- args[1]
input2 <- args[2]
output <- args[3]

setwd('/home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/')
file_names <- list.files()
file_names <- file_names[grep('.beta',file_names)]     #记录beta文件名信息
tissues <- sapply(strsplit(file_names,'\\.'),'[',1)     #拆分字符串得到tissue信息
colnames_tissues_res <- c()
for (i in 1:length(file_names)){
  tissue_meth <- paste0(tissues[i],'_METH')     #记录对应tissue的meth列名
  tissue_depth <- paste0(tissues[i],'_DEPTH')     #记录对应tissue的depth列名
  colnames_tissues_res <- c(colnames_tissues_res,tissue_meth,tissue_depth)     #拼接成tissue的完整列名
}

bedtools_res <- read.table(input1)     
tims_summed <- read.table(input2)
tims <- tims_summed[1:3]

setwd("/home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/cfsort_dis")
file_names <- list.files()
file_names <- file_names[grep('.beta',file_names)]     #记录beta文件信息
which_100 <- which(file_names == "cfsort_dis_100_1.beta")  
file_names <- c(file_names,file_names[which_100])
file_names <- file_names[-which_100]     #调整文件信息，使之为1-100的顺序，方便后续操作
cpgs_all <- as.data.frame(matrix(ncol = 0,nrow = nrow(tims)))
colnames_samples_res <- c()
#两层循环：第一层循环为循环sample样本，第二层循环为循环regions信息
for (j in 1:length(file_names)){
  fname <- file_names[j]
  N <- file.info(fname)$size
  content <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)     #处理beta文件得到meth和depth信息
  sample_meth <- paste0('sample',j,'_METH')     #记录对应sample的meth列名
  sample_depth <- paste0('sample',j,'_DEPTH')     #记录对应sample的depth列名
  colnames_samples_res <- c(colnames_samples_res,sample_meth,sample_depth)     #拼接成sample的完整列名
  cpgs_res <- data.frame()
  for (k in 1:dim(tims)[1]){
    region_new <- tims[k,]
    find_index_new <- subset(bedtools_res,V1==region_new[,1] & V2==region_new[,2] & V3==region_new[,3])     #提取regions对应的cpgs点信息
    index_new <- find_index_new$V7
    if(length(index_new)==1){
      cpgs_new <- transpose(as.data.frame(content[index_new,]))
    }else{
      cpgs_new <- as.data.frame(content[index_new,])
    }
    cpgs_summed_new <- transpose(as.data.frame(colSums(cpgs_new)))     #regions内cpgs点的meth和depth的加和
    cpgs_res <- rbind(cpgs_res,cpgs_summed_new)     #单个sample的regions的信息
  }
  cpgs_all <- cbind(cpgs_all,cpgs_res)     #所有sample的regions信息的拼接
}

samples_data <- cpgs_all
tissues_data <- tims_summed
colnames(tissues_data) <- c('CHROM','START','END',colnames_tissues_res)
colnames(samples_data) <- colnames_samples_res
data_input <- cbind(tissues_data[,c(1:3)],samples_data,tissues_data)
write.table(data_input,file = output,quote = FALSE,row.names = FALSE,col.names = TRUE,sep = '\t')
