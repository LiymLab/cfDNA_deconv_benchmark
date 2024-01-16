library(data.table)

args <- commandArgs(trailingOnly = TRUE)
input <- args[1]
output <- args[2]

tissue_proportions <- fread(input,header = FALSE,check.names = FALSE)
tissue_proportions[1,1] <- 'ID'
t_tissue_proportions <- as.data.frame(t(tissue_proportions))
write.table(t_tissue_proportions,file = output,col.names = FALSE,row.names = FALSE,sep = ',',quote = FALSE)


