#usage:Rscript sample_metrics_evaluation.R inputfile outputfile distribution

cal_scores <- function(inputfile, outputfile, dis){
  library(DescTools)
  library(philentropy)
  
  #### Define four computational functions ####
  extract_number_ref <- function(col_name) {
    as.integer(sub("D", "", col_name))
  }
  
  calculate_rmse <- function(x, y) {
    sqrt(mean((x - y)^2))
  }
  calculate_pearson <- function(x, y) {
    cor(x, y, method = "pearson")
  }
  calculate_spearman <- function(x, y) {
    cor(x, y, method = "spearman")
  }
  calculate_CCC <- function(x, y) {
    ccc_result <- CCC(x, y, conf.level = 0.95)
    return(ccc_result$rho.c[1, 1]) 
  }
  
  deconv_df <- read.csv(inputfile, header = TRUE, row.names = 1)
  cat("Processing file:", inputfile, "\n")
  colnames(deconv_df) <- gsub("dirichlet", "dirichle", colnames(deconv_df))
  
  if (dis == "uniform_dis" ){
    ref_pro <- read.csv("～/uniform_matrix_d.csv", header = TRUE, row.names = 1) #ground truth promotion
    extract_number_deconv <- function(col_name) {
      as.integer(sub("uniform_(\\d+)_1", "\\1", col_name)) + 1
      }
    } else if (dis == "cfsort_dis"){
      ref_pro <- read.csv("～/cfsort_dis.csv", row.names = 1)
      extract_number_deconv <- function(col_name) {
        as.integer(sub("cfsort_dis_(\\d+)_1", "\\1", col_name))
      }
    } else {
      ref_pro <- read.csv("～/dirichlet_matrix_0.5.csv", row.names = 1)
      extract_number_deconv <- function(col_name) {
        as.integer(sub("dirichle_(\\d+)_1", "\\1", col_name)) + 1
      }
    }
  
  rownames(ref_pro) <- gsub("-", ".", rownames(ref_pro))
  rownames(ref_pro) <- gsub("\\+", ".", rownames(ref_pro))
  
  rownames(deconv_df) <- gsub("-", ".", rownames(deconv_df))
  rownames(deconv_df) <- gsub("\\+", ".", rownames(deconv_df))
  
  if (!all(rownames(ref_pro) == rownames(deconv_df))) {
    ref_pro <- ref_pro[match(rownames(ref_pro), rownames(deconv_df)), ]
  }
  
  if (all(rownames(ref_pro) == rownames(deconv_df))) {
    print("Row names are the same.")
  } else {
    print("Row names are not identical.")
  }
  
  Cal_results <- data.frame(ref_col = character(), deconv_col = character(), rmse_value = numeric(), pearson_value = numeric(), CCC_value = numeric(), JSD_value = numeric(), spearman_value = numeric())
  for (col1 in colnames(ref_pro)) {
    num1 <- extract_number_ref(col1)
    if (dis == "uniform_dis" ){
      col2_name <- paste0("uniform_", sprintf("%02d", num1 - 1), "_1")
    }else if (dis == "cfsort_dis"){
      col2_name <- paste0("cfsort_dis_", sprintf("%02d", num1), "_1")
    }else {
      col2_name <- paste0("dirichle_", sprintf("%02d", num1 - 1), "_1")
    }
    
    if (col2_name %in% colnames(deconv_df)) {
      rmse <- calculate_rmse(ref_pro[[col1]], deconv_df[[col2_name]])
      pearson <- calculate_pearson(ref_pro[[col1]], deconv_df[[col2_name]])
      spearman <- calculate_spearman(ref_pro[[col1]], deconv_df[[col2_name]])
      ccc <- calculate_CCC(ref_pro[[col1]], deconv_df[[col2_name]])
      jsd <- JSD(rbind(ref_pro[[col1]], deconv_df[[col2_name]]),unit = "log2",est.prob = "empirical")
      
      Cal_results <- rbind(Cal_results, data.frame(ref_col = col1, deconv_col = col2_name, rmse_value = rmse, pearson_value = pearson, CCC_value = ccc, JSD_value = jsd, spearman_value = spearman))
    }
  }
  write.csv(Cal_results, outputfile, row.names = FALSE)
}

args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 3) {
  stop("Please provide exactly three arguments: inputfile, outputfile, dis.")
}
cal_scores(args[1], args[2], args[3])
