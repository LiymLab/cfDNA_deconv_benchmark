
cal_all<-function(cfnome,methatlas,celfeer,celfie,uxm,output_file){

  #Read the files calculated by the sample_metrics_evaluation.R script using five methods, which store the results of five evaluation metrics.
  cfnome_DF <- read.table(cfnome,header = T)  
  MethAtlas_DF <- read.table(methatlas,header = T)   
  CelFiE_DF <- read.table(celfeer,header = T)  
  CelFEER_DF <- read.table(celfie,header = T)  
  UXM_DF <- read.table(uxm,header = T)  

  #cal normalize score
  new_cfnome_df <- data.frame()
  new_methatlas_df <- data.frame()
  new_celfeer_df <- data.frame()
  new_celfie_df <- data.frame()
  new_uxm_df <- data.frame()
  
  out<-data.frame()
  for (i in 1:100) {
    row_name <- paste0("D", i)

    tmp_cfnome <- subset(cfnome_DF, ref_col == row_name, drop = FALSE)
    tmp_methatlas <- subset(MethAtlas_DF, ref_col == row_name, drop = FALSE)
    tmp_celfeer <- subset(CelFEER_DF, ref_col == row_name, drop = FALSE)
    tmp_celfie <- subset(CelFiE_DF, ref_col == row_name, drop = FALSE)
    tmp_uxm <- subset(UXM_DF, ref_col == row_name, drop = FALSE)
    
    data_frames <- list(tmp_cfnome, tmp_methatlas, tmp_celfeer, tmp_celfie, tmp_uxm)
    all_the_same <- TRUE
    for (i in seq_along(data_frames)) {
      if (i == 1) {
        reference_colnames <- colnames(data_frames[[i]])
      } else if (!identical(reference_colnames, colnames(data_frames[[i]]))) {
        all_the_same <- FALSE
        break
      }
    }
    if (all_the_same) {
      tmp_df <- do.call(rbind, data_frames)
    } else {
      warning("Column names do not match.")
    }
    
    negative_indicators <- c("rmse_value", "JSD_value")
    score <- matrix(nrow = nrow(tmp_df), ncol = ncol(tmp_df))
    rownames(score) <- rownames(tmp_df)
    colnames(score) <- colnames(tmp_df)
    

    for (col in c("rmse_value"   ,  "pearson_value" , "CCC_value" ,     "JSD_value"   ,   "spearman_value")) {
      for (row in 1:nrow(tmp_df)){
        if (col %in% negative_indicators) {
          max_num <- max(tmp_df[,col])
          min_num <- min(tmp_df[,col])
          num <- tmp_df[row,col]
          score[row,col] <- 1 - (num - min_num) / (max_num - min_num)
          
          score[row,"ref_col"]<-tmp_df[row,"ref_col"]
          score[row,"class"]<-tmp_df[row,"class"] 
# class represents the data grouping label, for example, in the depth filter section, we have set 17 depth filter thresholds, and class corresponds to these 17 thresholds (15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 150, 200, 250, and 300).

          score[row,"Method"]<-tmp_df[row,"Method"]
        } else {
          max_num <- max(tmp_df[,col])
          min_num <- min(tmp_df[,col])
          num <- tmp_df[row,col]
          score[row,col] <- (num - min_num) / (max_num - min_num)
          
          score[row,"ref_col"]<-tmp_df[row,"ref_col"]
          score[row,"class"]<-tmp_df[row,"class"]
          score[row,"Method"]<-tmp_df[row,"Method"]
        }}
      
    }

    score <- as.data.frame(score)
    score$rmse_value <- as.numeric(as.character(score$rmse_value))
    score$pearson_value <- as.numeric(as.character(score$pearson_value))
    score$CCC_value <- as.numeric(as.character(score$CCC_value))
    score$JSD_value <- as.numeric(as.character(score$JSD_value))
    score$spearman_value <- as.numeric(as.character(score$spearman_value))
    sapply(score[, c("rmse_value", "pearson_value", "CCC_value", "JSD_value", "spearman_value")], class)
    
    score$value <- rowMeans(score[, c("rmse_value", "pearson_value", "CCC_value", "JSD_value", "spearman_value")], na.rm = TRUE)
    print(table(score$Method, score$class))
    
    grouped_scores <- aggregate(value ~ Method + class, data = score, mean, na.rm = TRUE)
    grouped_scores <- as.data.frame(grouped_scores)
    
    out<-rbind(out,grouped_scores)
  }
  print(table(out$Method,out$class))
  write.table(out,output_file,quote = F,col.names = T,row.names = F)
  
}
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 11) {
  stop("Please provide exactly three arguments: inputfile, outputfile, dis.")
}
cal_all(args[1], args[2], args[3],args[4], args[5], args[6],args[7], args[8], args[9],args[10], args[11])
