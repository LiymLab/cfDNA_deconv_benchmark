library(data.table)

args <- commandArgs(trailingOnly = TRUE)
input_data <- args[1]
output_data <- args[2]

data_full <- fread('~/celfeer_work2/data_full.txt')
colnames(data_full)[1:3] <- c('chrom','start','end')
markers <- fread(input_data)
markers <- markers[,1:3]
data_input <- merge(markers,data_full,by = c('chrom','start','end'),all.x = TRUE,sort = FALSE)
write.table(data_input,file = output_data,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')
