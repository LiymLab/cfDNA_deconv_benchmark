
##Read the marker file selected by the four methods, the file needs to contain target and methylation information

MethAtlas <- read.csv("~/meth_atlas_markers.csv", header = TRUE)
UXM<- read.table("~/UXM_markers",header = TRUE)
CelFiE<-read.csv("~/celfie_markers.csv",header = T)
CelFEER<-read.csv("~/celfeer_markers.csv",header = T)

#1、Calculate the statistical difference in methylation levels between the target cell type and other cell types using t-tests and p-values. #

################################################################################################
#                                                                                              #
#                                              UXM                                             #
#                                                                                              #
################################################################################################

# calculate t-test p-value
colnames_check <- colnames(UXM)[9:ncol(UXM)]
UXM$target <- gsub("-", ".", UXM$target) 
UXM$target <- gsub("\\+", ".", UXM$target) 
target_values <- unique(UXM$target)

if(all(target_values %in% colnames_check)){
  UXM_sorted <- UXM[order(UXM$target), ]
  sta_df <- data.frame(matrix(ncol = 3, nrow = nrow(UXM_sorted)))
  colnames(sta_df) <- c("target", "name", "p_value")
  for(i in 1:nrow(UXM_sorted)){
    target_col <- as.character(UXM_sorted$target[i]) 
    non_target_cols <- colnames_check[colnames_check != target_col]
    target_values <- as.numeric(UXM_sorted[i,target_col])
    other_values <- as.numeric(UXM_sorted[i, non_target_cols, drop = FALSE])
    
    if (is.na(target_values)) {
      next
    }
    
    test <- t.test(other_values, mu = target_values)
    sta_df[i, "target"] <- target_col
    sta_df[i, "name"] <- UXM_sorted$name[i]
    sta_df[i, "p_value"] <- test$p.value
  }
  print(sta_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}
uxm_sta<-sta_df
uxm_sta$Method<-"UXM"

################################################################################################
#                                                                                              #
#                                            CelFiE                                            #
#                                                                                              #
################################################################################################
colnames_check <- colnames(CelFiE)[5:ncol(CelFiE)]
CelFiE$tissue <- gsub("-", ".", CelFiE$tissue) 
CelFiE$tissue <- gsub("\\+", ".", CelFiE$tissue) 
target_values <- unique(CelFiE$tissue) 

if(all(target_values %in% colnames_check)){
  CelFiE_sorted <- CelFiE[order(CelFiE$tissue), ]
  sta_df <- data.frame(matrix(ncol = 3, nrow = nrow(CelFiE)))
  colnames(sta_df) <- c("target", "name", "p_value")
  for(i in 1:nrow(CelFiE_sorted)){
    tissue_col <- as.character(CelFiE_sorted$tissue[i]) 
    non_tissue_cols <- colnames_check[colnames_check != tissue_col]
    tissue_values <- as.numeric(CelFiE_sorted[i,tissue_col])
    other_values <- as.numeric(CelFiE_sorted[i, non_tissue_cols, drop = FALSE])

    if (is.na(tissue_values)) {
      next
    }
    test <- t.test(other_values, mu = tissue_values)
    sta_df[i, "target"] <- tissue_col
    sta_df[i, "name"] <- CelFiE_sorted$end[i]
    sta_df[i, "p_value"] <- test$p.value
  }
  print(sta_df)
} else {
  stop("One or more tissue values are not in the column names from column 9 to the last.")
}
celfie_sta<-sta_df
celfie_sta$Method<-"CelFiE"
################################################################################################
#                                                                                              #
#                                           CelFEER                                            #
#                                                                                              #
################################################################################################
colnames_check <- colnames(CelFEER)[5:ncol(CelFEER)]
CelFEER$target <- gsub("-", ".", CelFEER$target) 
CelFEER$target <- gsub("\\+", ".", CelFEER$target) 
target_values <- unique(CelFEER$target) 

if(all(target_values %in% colnames_check)){
  CelFEER_sorted <- CelFEER[order(CelFEER$target), ]
  sta_df <- data.frame(matrix(ncol = 3, nrow = nrow(CelFEER)))
  colnames(sta_df) <- c("target", "name", "p_value")
  for(i in 1:nrow(CelFEER_sorted)){
    tissue_col <- as.character(CelFEER_sorted$target[i]) 
    non_tissue_cols <- colnames_check[colnames_check != tissue_col]
    tissue_values <- as.numeric(CelFEER_sorted[i,tissue_col])
    other_values <- as.numeric(CelFEER_sorted[i, non_tissue_cols, drop = FALSE])
    
    if (is.na(tissue_values)) {
      next
    }
    test <- t.test(other_values, mu = tissue_values)
    sta_df[i, "target"] <- tissue_col
    sta_df[i, "name"] <- CelFEER_sorted$end[i]
    sta_df[i, "p_value"] <- test$p.value
  }
  print(sta_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}
celfeer_sta<-sta_df
celfeer_sta$Method<-"CelFEER"
################################################################################################
#                                                                                              #
#                                           MethAtlas                                          #
#                                                                                              #
################################################################################################
colnames_check <- colnames(MethAtlas)[3:ncol(MethAtlas)]
MethAtlas$ct_name <- gsub("-", ".", MethAtlas$ct_name) 
MethAtlas$ct_name <- gsub("\\+", ".", MethAtlas$ct_name) 
target_values <- unique(MethAtlas$ct_name) 

if(all(target_values %in% colnames_check)){
  MethAtlas_sorted <- MethAtlas[order(MethAtlas$ct_name), ]
  sta_df <- data.frame(matrix(ncol = 3, nrow = nrow(MethAtlas)))
  colnames(sta_df) <- c("target", "name", "p_value")
  for(i in 1:nrow(MethAtlas_sorted)){
    tissue_col <- as.character(MethAtlas_sorted$ct_name[i]) 
    non_tissue_cols <- colnames_check[colnames_check != tissue_col]
    tissue_values <- as.numeric(MethAtlas_sorted[i,tissue_col])
    other_values <- as.numeric(MethAtlas_sorted[i, non_tissue_cols, drop = FALSE])
    
    if (is.na(tissue_values)) {
      next
    }
    test <- t.test(other_values, mu = tissue_values)
    sta_df[i, "target"] <- tissue_col
    sta_df[i, "name"] <- MethAtlas_sorted$idx[i]
    sta_df[i, "p_value"] <- test$p.value
  }
  print(sta_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}
ma_sta<-sta_df
ma_sta$Method<-"MethAtlas"


#2、calculate the absolute difference in methylation levels between the target cell type and all others

################################################################################################
#                                                                                              #
#                                              UXM                                             #
#                                                                                              #
################################################################################################
colnames_check <- colnames(UXM)[9:ncol(UXM)]
UXM$target <- gsub("-", ".", UXM$target) 
UXM$target <- gsub("\\+", ".", UXM$target) 
target_values <- unique(UXM$target)

if(all(target_values %in% colnames_check)){
  UXM_sorted <- UXM[order(UXM$target), ]
  diff_df <- data.frame(matrix(ncol = 3, nrow = nrow(UXM)))
  rownames(diff_df) <- 1:nrow(UXM_sorted)
  colnames(diff_df) <- c("target", "name", "value")
  
  for(i in 1:nrow(UXM_sorted)){
    target_col <- as.character(UXM_sorted$target[i]) 
    non_target_cols <- colnames_check[colnames_check != target_col]

    mean_value <- mean(as.numeric(UXM_sorted[i, non_target_cols]), na.rm = TRUE)
    target_value <- as.numeric(UXM_sorted[i, target_col])

    diff_value <- abs(target_value - mean_value)
    
    diff_df[i, "target"] <- target_col
    diff_df[i, "name"] <- UXM_sorted$name[i]
    diff_df[i, "value"] <- diff_value
  }
  print(diff_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}
uxm_dif <- diff_df[,c("target","value")]
uxm_dif$Method<-"UXM"

################################################################################################
#                                                                                              #
#                                            CelFiE                                            #
#                                                                                              #
################################################################################################
colnames_check <- colnames(CelFiE)[5:ncol(CelFiE)]
CelFiE$tissue <- gsub("-", ".", CelFiE$tissue) 
CelFiE$tissue <- gsub("\\+", ".", CelFiE$tissue) 
target_values <- unique(CelFiE$tissue) 

if(all(target_values %in% colnames_check)){
  CelFiE_sorted <- CelFiE[order(CelFiE$tissue), ]
  diff_df <- data.frame(matrix(ncol = 3, nrow = nrow(CelFiE)))
  rownames(diff_df) <- 1:nrow(CelFiE_sorted)
  colnames(diff_df) <- c("target", "name", "value")
  
  for(i in 1:nrow(CelFiE_sorted)){
    target_col <- as.character(CelFiE_sorted$tissue[i]) 
    non_target_cols <- colnames_check[colnames_check != target_col]
    
    mean_value <- mean(as.numeric(CelFiE_sorted[i, non_target_cols]), na.rm = TRUE)
    target_value <- as.numeric(CelFiE_sorted[i, target_col])

    diff_value <- abs(target_value - mean_value)

    diff_df[i, "target"] <- target_col
    diff_df[i, "name"] <- CelFiE_sorted$tissue[i]

    diff_df[i, "value"] <- diff_value
  }
  print(diff_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}

CelFiE_dif <- diff_df[,c("target","value")]
CelFiE_dif$Method<-"CelFiE"
################################################################################################
#                                                                                              #
#                                           CelFEER                                            #
#                                                                                              #
################################################################################################
colnames_check <- colnames(CelFEER)[5:ncol(CelFEER)]
CelFEER$target <- gsub("-", ".", CelFEER$target) 
CelFEER$target <- gsub("\\+", ".", CelFEER$target) 
target_values <- unique(CelFEER$target) 

if(all(target_values %in% colnames_check)){
  CelFEER_sorted <- CelFEER[order(CelFEER$target), ]
  diff_df <- data.frame(matrix(ncol = 3, nrow = nrow(CelFEER)))
  rownames(diff_df) <- 1:nrow(CelFEER_sorted)
  colnames(diff_df) <- c("target", "name", "value")
  
  for(i in 1:nrow(CelFEER_sorted)){
    target_col <- as.character(CelFEER_sorted$target[i]) 
    non_target_cols <- colnames_check[colnames_check != target_col]

    mean_value <- mean(as.numeric(CelFEER_sorted[i, non_target_cols]), na.rm = TRUE)
    target_value <- as.numeric(CelFEER_sorted[i, target_col])
    diff_value <- abs(target_value - mean_value)
    diff_df[i, "target"] <- target_col
    diff_df[i, "name"] <- CelFEER_sorted$target[i]
    
    diff_df[i, "value"] <- diff_value
  }
  print(diff_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}

CelFEER_dif <- diff_df[,c("target","value")]
CelFEER_dif$Method<-"CelFEER"

################################################################################################
#                                                                                              #
#                                           MethAtlas                                          #
#                                                                                              #
################################################################################################
colnames_check <- colnames(MethAtlas)[3:ncol(MethAtlas)]
MethAtlas$ct_name <- gsub("-", ".", MethAtlas$ct_name) 
MethAtlas$ct_name <- gsub("\\+", ".", MethAtlas$ct_name) 
target_values <- unique(MethAtlas$ct_name) 

if(all(target_values %in% colnames_check)){
  MethAtlas_sorted <- MethAtlas[order(MethAtlas$ct_name), 
  diff_df <- data.frame(matrix(ncol = 3, nrow = nrow(MethAtlas)))
  rownames(diff_df) <- 1:nrow(MethAtlas_sorted) 
  colnames(diff_df) <- c("target", "name", "value")
  
  for(i in 1:nrow(MethAtlas_sorted)){
    target_col <- as.character(MethAtlas_sorted$ct_name[i]) 
    non_target_cols <- colnames_check[colnames_check != target_col]

    mean_value <- mean(as.numeric(MethAtlas_sorted[i, non_target_cols]), na.rm = TRUE)
    target_value <- as.numeric(MethAtlas_sorted[i, target_col])

    diff_value <- abs(target_value - mean_value)

    diff_df[i, "target"] <- target_col
    diff_df[i, "name"] <- MethAtlas_sorted$ct_name[i]

    diff_df[i, "value"] <- diff_value
  }

  print(diff_df)
} else {
  stop("One or more target values are not in the column names from column 9 to the last.")
}

MethAtlas_dif <- diff_df[,c("target","value")]
MethAtlas_dif$Method<-"MethAtlas/cfNOMe"

