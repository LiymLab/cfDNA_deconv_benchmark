library(data.table)

bedtools_res <- read.table('/intersect_res.bed') # the index information of CpGs within the regions covered by the markers obtained using the intersect function of BEDTools
tims <- read.table('/markers.bed') # the BED file of the markers

file_path <- "/home/sty/cfDNA_benchmark/benchmark_pat/pat_merged/ref/" # path storing reference data; change the path according to your actual situation
file_names <- list.files(file_path)
file_names <- file_names[grep('.beta',file_names)]     
tissues <- sapply(strsplit(file_names,'\\.'),'[',1)
cpgs_all <- as.data.frame(matrix(ncol = 0,nrow = nrow(tims)))

# for markers of uxm/celfeer:
for (j in 1:length(file_names)){
  fname <- paste0(file_path,file_names[j])
  N <- file.info(fname)$size
  content <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)     
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

# for markers of cfnome/methatlas:
for (j in 1:length(file_names)){
  fname <- paste0(file_path,file_names[j])
  N <- file.info(fname)$size
  content <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)     
  content <- data.frame(content[index,])
  cpgs_all <- cbind(cpgs_all,content)
}

ref_data <- cbind(tims,cpgs_all)
write.table(ref_data,file = '/sample_input_tims_summed.txt',sep = '\t',quote = FALSE,row.names = FALSE,col.names = FALSE)
