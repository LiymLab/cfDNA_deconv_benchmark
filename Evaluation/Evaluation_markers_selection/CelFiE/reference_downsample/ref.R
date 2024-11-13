args <- commandArgs(trailingOnly = TRUE)
input <- args[1]
output <- args[2]

file_names <- list.files(input)
file_names <- file_names[grep('.beta',file_names)]
tissues <- sapply(strsplit(file_names,'\\.'),'[',1)

fname <- paste0(input,file_names[1])
N <- file.info(fname)$size
content <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)
content_res <- as.data.frame(matrix(ncol = 0,nrow = nrow(content)))
colnames <- c()
for (i in 1:length(file_names)){
  fname <- paste0(input,file_names[i])
  N <- file.info(fname)$size
  content_new <- matrix(readBin(fname, "integer", N, size = 1, signed = FALSE), N / 2, 2, byrow=TRUE)
  content_res <- cbind(content_res,content_new)
  meth_new <- paste0(tissues[i],'_METH')
  depth_new <- paste0(tissues[i],'_DEPTH')
  colnames <- c(colnames,meth_new,depth_new)
}
bed <- read.table("/home/sty/bed_hg38/bed_hg38.bed",sep='\t')
ref <- cbind(bed[1:3],content_res)
write.table(ref,file=output,row.names = FALSE,col.names = FALSE,sep = '\t',quote = FALSE)