args <- commandArgs(trailingOnly = TRUE)     #接收参数
input <- args[1]
tissue <- args[2]

data_full <- read.table(input,header = TRUE,sep = '\t',check.names = FALSE)
tissue_meth <- paste0(tissue,'_METH')
tissue_depth <- paste0(tissue,'_DEPTH')
data_drop <- data_full[,-grep(tissue_meth,colnames(data_full))]     #去除选择的cell type的meth信息对应的索引的数据
data_drop <- data_drop[,-grep(tissue_depth,colnames(data_drop))]     #去除选择的cell type的depth信息对应的索引的数据
colnames(data_drop)[204:206] <- c('CHROM','METH','DEPTH')
data_name <- paste0('~/celfie_work2/celfie_drop_tissue/data_median_15_drop_',tissue,'/data_input.txt')
write.table(data_drop,file = data_name,sep = '\t',col.names = TRUE,row.names = FALSE,quote = FALSE)
