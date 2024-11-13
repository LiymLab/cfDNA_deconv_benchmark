#statistical differences in cfDNA fractions derived from affected tissues between diseased and healthy individuals
disease_categories <- c("HCC", "COAD", "LIHC", "LUSC", "STAD", "LUAD")
for (category in disease_categories){
methods <- c("CelFEER","CelFiE","cfNOMe","MethAtlas","UXM")
plots <- list()
p_values <- numeric(length(methods)) 
for (i in seq_along(methods)) {
  method <- methods[i]
  load(paste0("/data/LJQ/project/decov/real_data/", category, "/", category, "_", method, "_data.RData"))
  df <- as.data.frame(data[ , grepl("affected_tissues", colnames(data)), drop = FALSE])###Tissue types associated with disease
  df[] <- lapply(df, function(x) as.numeric(as.character(x)))
  df$Group <- ifelse(grepl("CTR|normal", rownames(df)), "Control", category)
  column <- colnames(df)[grepl("affected_tissues", colnames(df))][1]
  plot_data <- df %>%
    group_by(Group) %>%
    summarize(mean_value = mean(get(column), na.rm = TRUE),
              se_value = sd(get(column), na.rm = TRUE) / sqrt(n()))
  plot_data$Group <- factor(plot_data$Group, levels = c("Control", category))
  control_data <- df[grepl("CTR|normal", rownames(df)), column, drop = FALSE]
  category_data <- df[!grepl("CTR|normal", rownames(df)), column, drop = FALSE]
  wilcox_test_result <- wilcox.test(control_data[[1]], category_data[[1]], alternative = "less", exact = FALSE)
  p_value <- wilcox_test_result$p.value
  p_values[i] <- -log10(p_value)
  formatted_p_value <- ifelse(p_value < 0.001, 
                              formatC(signif(p_value, digits = 2), format = "e", digits = 1), 
                              signif(p_value, digits = 2))
  
  p <- ggplot(plot_data, aes(x = Group, y = mean_value, fill = Group)) +
    geom_bar(stat = "identity", width = 0.4, position = position_dodge(0), alpha = 0.4) + 
    geom_errorbar(aes(ymin = mean_value - se_value, ymax = mean_value + se_value), 
                  width = 0.2) +  
    scale_fill_manual(values = c("Control" = "#002A5C", "HCC" = "#A50034")) +
    theme_classic() +
    theme(axis.text.x = element_text(size = 8),  
          axis.text.y = element_text(size = 8),
          axis.title.y = element_text(size = 8),
          panel.spacing = unit(0, "lines"), 
          plot.margin = margin(0, 0, 0, 0),
          legend.position = "none") + 
    scale_y_continuous(expand = c(0, 0)) +
    labs(title = method, x = " ", y = "Affected_tissues Proportion") +
    ggtitle(method) +
    annotate("text", x = 1.0, y = max(plot_data$mean_value)*1.1, label = paste(" p =",  formatted_p_value), size = 2.5, hjust = 0)
  plots[[method]] <- p
}

p_value_df <- data.frame(Method = methods, Log10PValue = p_values)
write.table(p_value_df, file = paste0("/data/LJQ/project/decov/real_data/", category, "/p_values.txt"), 
            sep = "\t", row.names = FALSE, quote = FALSE)

library(gridExtra)
for (i in 1:length(plots)) {
  plots[[i]] <- plots[[i]] + theme(plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))  # 调整为你想要的边距
}
combined_plot = grid.arrange(grobs = plots, ncol = 5)
ggsave(paste0("~/project/decov/real_data/",category,"/",category,"_barplot.pdf"), plot = combined_plot, width = 10, height = 2)
}
###AUC values to evaluating the accuracy of disease detection
rm(list = ls()) 
library(pROC)
library(stringr) 
library(parallel) 
library(ggplot2)
Rdata = "/public/home/ljq/project/decov2/real_data/disease/disease_method_data.RData"###Tissue proportions of different datasets calculated using different methods
prefix = "Corresponding data sets"
out_dir ="/public/home/ljq/project/decov2/real_data/disease/"

load(Rdata)
#set the model function
models = function(index){ 
  set.seed(1) 
  library(stringr) 
  library(randomForest) 
  library(glmnet)
  library(e1071)
  library(xgboost)
  
  load(Rdata)
  data=as.data.frame(data)
  if (any(grepl("[-+]", colnames(data)))) {
    colnames(data) <- gsub("[-+]", "_", colnames(data))
  }
  data <- as.data.frame(lapply(data, as.numeric), row.names = rownames(data))
  #leave-one-out cross validation
  train_data = data[rownames(data) != index,]
  test_data = data[index,]
  group = !str_detect(rownames(train_data), 'CTR|normal')
  #random forest
  setwd(out_dir)
  train_data$group = factor(ifelse(group,'tumor','normal'),levels = c('normal','tumor'))
  rf = randomForest(group~.,
                    train_data,
                    ntree = 200,
                    importance = F,
                    proximity = F)
  rf_pre = predict(rf,newdata=test_data)
  rf_pro = predict(rf,newdata=test_data,type = 'prob')
  write(paste0(names(rf_pre),"\t",as.character(rf_pre),"\t",rf_pro[,2],"\n"),
        file = paste0(prefix,"_RandomForest_predict_result.txt"),append = T)  
}

#parallel computing
cl = makeCluster(threads)
clusterExport(cl,c("Rdata","prefix","out_dir"))
clusterApply(cl,rownames(data[,colnames(data) != 'group']),models)
stopCluster(cl)
#ROC
library(pROC)
library(stringr)
data_dir= "/public/home/ljq/project/decov2/real_data/disease/"
setwd(data_dir) 
model <- "RandomForest"
#MethAtlas CelFiE CelFEER UXM cfNOMe
  celfeer_data <- read.table(paste0("CelFEER_", model, "_predict_result.txt"), sep = "\t", header = FALSE)
  celfie_data <- read.table(paste0("CelFiE_", model, "_predict_result.txt"), sep = "\t", header = FALSE)
  cfNOMe_data <- read.table(paste0("cfNOMe_", model, "_predict_result.txt"), sep = "\t", header = FALSE)
  meth_atlas_data <- read.table(paste0("MethAtlas_", model, "_predict_result.txt"), sep = "\t", header = FALSE)
  UXM_data <- read.table(paste0("UXM_", model, "_predict_result.txt"), sep = "\t", header = FALSE)
  
  colnames(celfeer_data) <- c('sample', 'pred', 'prob')
  colnames(celfie_data) <- c('sample', 'pred', 'prob')
  colnames(cfNOMe_data) <- c('sample', 'pred', 'prob')
  colnames(meth_atlas_data) <- c('sample', 'pred', 'prob')
  colnames(UXM_data) <- c('sample', 'pred', 'prob')
  
  roc_obj1 <- roc(ifelse(str_detect(celfeer_data$sample, 'CTR|normal'), 'normal', 'tumor'), celfeer_data$prob)
  roc_obj2 <- roc(ifelse(str_detect(celfie_data$sample, 'CTR|normal'), 'normal', 'tumor'), celfie_data$prob)
  roc_obj3 <- roc(ifelse(str_detect(cfNOMe_data$sample, 'CTR|normal'), 'normal', 'tumor'), cfNOMe_data$prob)
  roc_obj4 <- roc(ifelse(str_detect(meth_atlas_data$sample, 'CTR|normal'), 'normal', 'tumor'), meth_atlas_data$prob)
  roc_obj5 <- roc(ifelse(str_detect(UXM_data$sample, 'CTR|normal'), 'normal', 'tumor'), UXM_data$prob)
  
  auc_celfeer = auc(roc_obj1)
  auc_celfie = auc(roc_obj2)
  auc_cfNOMe = auc(roc_obj3)
  auc_meth_atlas = auc(roc_obj4)
  auc_UXM = auc(roc_obj5)
  
  pdf(paste0("aucs_", model, ".pdf"), width = 5, height = 5)
  
  plot(roc_obj1, col = "blue", lwd = 2, main = model)  
  lines(roc_obj2, col = "#ff6347", lwd = 2) 
  lines(roc_obj3, col = "#32a852", lwd = 2) 
  lines(roc_obj4, col = "#ffa500", lwd = 2)
  lines(roc_obj5, col = "#8a2be2", lwd = 2) 
  legend("bottomright", 
         legend = c(paste("CelFEER(AUC =", round(auc_celfeer, 2), ")"), 
                    paste("CelFiE(AUC =", round(auc_celfie, 2), ")"), 
                    paste("cfNOMe(AUC =", round(auc_cfNOMe, 2), ")"),
                    paste("MethAtlas(AUC =", round(auc_meth_atlas, 2), ")"),
                    paste("UXM(AUC =", round(auc_UXM, 2), ")")), 
         col = c("blue", "#ff6347", "#32a852", "#ffa500", "#8a2be2"), lwd = 2, cex = 0.8)
  dev.off()
