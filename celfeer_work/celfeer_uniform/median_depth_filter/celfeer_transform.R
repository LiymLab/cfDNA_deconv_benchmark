library(data.table)

args <- commandArgs(trailingOnly = TRUE)     #接收参数
input <- args[1]
output <- args[2]

tissue_proportions <- fread(input,header = FALSE,check.names = FALSE)
tissue_proportions[1,1] <- 'ID'     #填充'ID'
t_tissue_proportions <- as.data.frame(t(tissue_proportions))     #转置数据框得到所需数据框形式
write.table(t_tissue_proportions,file = output,col.names = FALSE,row.names = FALSE,sep = ',',quote = FALSE)