library(data.table)

args <- commandArgs(trailingOnly = TRUE)
full_data <- args[1]
input_data <- args[2]
output_data <- args[3]

data_full <- fread(full_data)
colnames(data_full)[1:3] <- c('chrom','start','end')
markers <- fread(input_data, select = c('chrom', 'start', 'end'))
data_input <- merge(markers,data_full,by = c('chrom','start','end'),all.x = TRUE,sort = FALSE)
fwrite(data_input,file = output_data,row.names = FALSE,col.names = FALSE,quote = FALSE,sep = '\t')