library(data.table)

#bedtools intersect -a tims_bed.bed -b bed.bed -wa -wb > bedtools_res_new.bed

args <- commandArgs(trailingOnly = TRUE)
input1 <- args[1]
input2 <- args[2]
input3 <- args[3]
output <- args[4]

file_names <- list.files('/home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/')
file_names <- file_names[grep('.beta',file_names)]
tissues <- sapply(strsplit(file_names,'\\.'),'[',1)
colnames_tissues_res <- c()
for (i in 1:length(file_names)){
  tissue_meth <- paste0(tissues[i],'_METH')
  tissue_depth <- paste0(tissues[i],'_DEPTH')
  colnames_tissues_res <- c(colnames_tissues_res,tissue_meth,tissue_depth)
}

bedtools_res <- read.table(input1)
tims_summed <- read.table(input2)
tims <- tims_summed[1:3]

file_names <- list.files(input3)
file_names <- file_names[grep('.beta',file_names)]

if(grepl('uniform',input3)){
}else if(grepl('crd',input3)){
  which_100 <- which(file_names == "crd_dis_100_1.beta")
  file_names <- c(file_names,file_names[which_100])
  file_names <- file_names[-which_100]
}else{
  which_100 <- which(file_names == "dirichlet_dis_100_1.beta")
  file_names <- c(file_names,file_names[which_100])
  file_names <- file_names[-which_100]
} #modify this part according to actual situation

cpgs_all <- as.data.frame(matrix(ncol = 0,nrow = nrow(tims)))
colnames_samples_res <- c()
for (j in 1:length(file_names)){
  fname <- paste0(input3,file_names[j])
  N <- file.info(fname)$size
  content <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)
  sample_meth <- paste0('sample',j,'_METH')
  sample_depth <- paste0('sample',j,'_DEPTH')
  colnames_samples_res <- c(colnames_samples_res,sample_meth,sample_depth)
  cpgs_res <- data.frame()
  for (k in 1:dim(tims)[1]){
    region_new <- tims[k,]
    find_index_new <- subset(bedtools_res,V1==region_new[,1] & V2==region_new[,2] & V3==region_new[,3])
    index_new <- find_index_new$V7
    if(length(index_new)==1){
      cpgs_new <- transpose(as.data.frame(content[index_new,]))
    }else{
      cpgs_new <- as.data.frame(content[index_new,])
    }
    cpgs_summed_new <- transpose(as.data.frame(colSums(cpgs_new)))
    cpgs_res <- rbind(cpgs_res,cpgs_summed_new)
  }
  cpgs_all <- cbind(cpgs_all,cpgs_res)
}

samples_data <- cpgs_all
tissues_data <- tims_summed
colnames(tissues_data) <- c('CHROM','START','END',colnames_tissues_res)
colnames(samples_data) <- colnames_samples_res
data_input <- cbind(tissues_data[,c(1:3)],samples_data,tissues_data)
write.table(data_input,file = output,quote = FALSE,row.names = FALSE,col.names = TRUE,sep = '\t')
