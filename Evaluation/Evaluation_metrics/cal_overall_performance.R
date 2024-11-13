## you can use this script to summarize the overall performance of each method across different datasets and evaluation factors

## 1、cal accuracy 
dfForACU <- data.frame()
for (i in c("uniform_dis","crd_dis","dirichlet_0.5_dis")){
  file <- paste0("/~/",i,"/default_15/median_15.txt")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForACU <- rbind(dfForACU,df)
}

ACUout <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  tmp <- subset(dfForACU, select = c(m, "dis"))
  median_score <- aggregate(. ~ dis, data = tmp, FUN = median)
  mean_score <- mean(median_score[, m], na.rm = TRUE)
  tmp_out <- data.frame(Method = m, value = mean_score,type = "Accuracy")
  ACUout <- rbind(ACUout, tmp_out)
}
print(ACUout)
ACUout$type2 <-"ACU"

row.names(ACUout)<-ACUout$Method
ACUOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(ACUout$value)
  min_num <- min(ACUout$value)
  num<-ACUout[col,"value"]
  score <- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = ACUout[col,"type"],type2 = ACUout[col,"type2"])
  ACUOut <- rbind(ACUOut,tmp)
}

## 2、cal sample downsample
dfForSample <- data.frame()
for (i in c("uniform","crd","dirichlet_0.5")){
  file <- paste0("/~/",i,"_dis/mix_downsample/normalized_score_mixdownsample_",i,".txt")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForSample <- rbind(dfForSample,df)
}
print(table(dfForSample$Method,dfForSample$Coverage))

Sampleout_tmp <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  tmp <- subset(dfForSample, Method == m)
  print(table(tmp$Coverage,tmp$dis))
  median_score <- aggregate(value ~ dis + Coverage , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ Coverage,median_score,mean)
  mean_score$Method <- m
  mean_score$type = "Robustness"
  Sampleout_tmp <- rbind(Sampleout_tmp, mean_score)
}
print(Sampleout_tmp)
Sampleout <- aggregate(value ~ Method,Sampleout_tmp,FUN = var)
Sampleout$type = "Robustness"
print(Sampleout)
Sampleout$type2 <-"sample ds"

row.names(Sampleout)<-Sampleout$Method
SampleOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(Sampleout$value)
  min_num <- min(Sampleout$value)
  num<-Sampleout[col,"value"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = Sampleout[col,"type"],type2 = Sampleout[col,"type2"])
  SampleOut <- rbind(SampleOut,tmp)
}

## 3、cal reference downsample
dfForRef <- data.frame()
for (i in c("uniform","crd","dirichlet_0.5")){
  file <- paste0("/~/",i,"_dis/ref_downsample/normalized_score_refdownsample.txt")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForRef <- rbind(dfForRef,df)
}
print(table(dfForRef$Method,dfForRef$Ratio))

Refout_tmp <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  tmp <- subset(dfForRef, Method == m)
  print(table(tmp$Ratio,tmp$dis))
  median_score <- aggregate(value ~ dis + Ratio , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ Ratio,median_score,mean)
  mean_score$Method <- m
  mean_score$type = "Robustness"
  Refout_tmp <- rbind(Refout_tmp, mean_score)
}
print(Refout_tmp)
Refout <- aggregate(value ~ Method,Refout_tmp,FUN = var)
Refout$type = "Robustness"
print(Refout)
Refout$type2 <-"ref ds"

row.names(Refout)<-Refout$Method
RefOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(Refout$value)
  min_num <- min(Refout$value)
  num<-Refout[col,"value"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = Refout[col,"type"],type2 = Refout[col,"type2"])
  RefOut <- rbind(RefOut,tmp)
}

## 4、cal missing marker

dfForMiss <- data.frame()
for (i in c("uniform","crd","dirichlet_0.5")){
  file <- paste0("/~/",i,"_dis/drop_markers/missing_markers_",i,"_dis.txt")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForMiss <- rbind(dfForMiss,df)
}
head(dfForMiss)
print(table(dfForMiss$Method,dfForMiss$Drop))

Missout_tmp <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  tmp <- subset(dfForMiss, Method == m)
  print(table(tmp$Drop,tmp$dis))
  median_score <- aggregate(value ~ dis + Drop , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ Drop,median_score,mean)
  mean_score$Method <- m
  mean_score$type = "Robustness"
  Missout_tmp <- rbind(Missout_tmp, mean_score)
}
print(Missout_tmp)
Missout <- aggregate(value ~ Method,Missout_tmp,FUN = var)
Missout$type = "Robustness"
print(Missout)
Missout$type2 <-"missing marker"

row.names(Missout)<-Missout$Method
MissOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(Missout$value)
  min_num <- min(Missout$value)
  num<-Missout[col,"value"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = Missout[col,"type"],type2 = Missout[col,"type2"])
  MissOut <- rbind(MissOut,tmp)
}

## 5、cal depth coverage

dfForDepth <- data.frame()
for (i in c("uniform","crd","dirichlet_0.5")){
  file <- paste0("/~/",i,"_dis/depth_filter/normalize_score.txt")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForDepth <- rbind(dfForDepth,df)
}
head(dfForDepth)
print(table(dfForDepth$Method,dfForDepth$depth))

Depthout_tmp <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  tmp <- subset(dfForDepth, Method == m)
  print(table(tmp$depth,tmp$dis))
  median_score <- aggregate(value ~ dis + depth , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ depth,median_score,mean)
  mean_score$Method <- m
  Depthout_tmp <- rbind(Depthout_tmp, mean_score)
}
print(Depthout_tmp)
Depthout <- aggregate(value ~ Method,Depthout_tmp,FUN = var)
Depthout$type = "Robustness"
print(Depthout)
Depthout$type2 <-"depth"

row.names(Depthout)<-Depthout$Method
DepthOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(Depthout$value)
  min_num <- min(Depthout$value)
  num<-Depthout[col,"value"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = Depthout[col,"type"],type2 = Depthout[col,"type2"])
  DepthOut <- rbind(DepthOut,tmp)
}

## 6、missing cell types

dfForCT <- data.frame()
for (i in c("uniform","crd","dirichlet_0.5")){
  file <- paste0("/~/",i,"_dis/drop_ct/drop_ct_raw.csv")
  df <- read.table(file,header = T)
  df$dis <- i
  dfForCT <- rbind(dfForCT,df)
}
head(dfForCT)
print(table(dfForCT$Method,dfForCT$Drop))

ct_non <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  df <- subset(dfForCT,Drop == "non-drop")
  tmp <- subset(df, Method == m)
  print(table(tmp$Drop,tmp$dis))
  median_score <- aggregate(value ~ dis + Drop , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ Drop,median_score,mean)
  mean_score$Method <- m
  ct_non <- rbind(ct_non, mean_score)
}

ct <- data.frame()
for (m in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas", "UXM")) {
  df <- subset(dfForCT,Drop != "non-drop")
  tmp <- subset(df, Method == m)
  print(table(tmp$dis))
  median_score <- aggregate(value ~ dis + Drop , data = tmp, FUN = median)
  mean_score <- aggregate(value ~ Drop,median_score,mean)
  mean_score$Method <- m
  ct <- rbind(ct, mean_score)
}
table(ct$Drop,ct$Method)
ct_out <- aggregate(value ~ Method,ct,mean)

merged_data <- merge(ct_out, ct_non, by = "Method", suffixes = c("_out", "_non"))
merged_data$value <- merged_data$value_out - merged_data$value_non
print(merged_data)
ctout <- merged_data[,c("Method","value")]
ctout$type <- "Robustness"
ctout$type2 <-"cell type drop"

row.names(ctout)<-ctout$Method
ctOut<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(ctout$value)
  min_num <- min(ctout$value)
  num<-ctout[col,"value"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score,type = ctout[col,"type"],type2 = ctout[col,"type2"])
  ctOut <- rbind(ctOut,tmp)
}

## 7、real data
#（1、AUC
auc <- read.table("/~/AUCs.txt",header =T,row.names = 1)
auc_mean <- colMeans(auc)
auc_mean<-data.frame(auc_mean)

auc_score<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(auc_mean)
  min_num <- min(auc_mean)
  num<-auc_mean[col,]
  score <- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score)
  auc_score <- rbind(auc_score,tmp)
}

auc_score$type <- "Real-world"
auc_score$type2 <-"auc"

#(2、p-value
pvalue <- read.table("/~/-log10pvalues.txt",header =T,row.names = 1)
pvalue_mean <- colMeans(pvalue)
pvalue_mean<-data.frame(pvalue_mean)

pvalue_score<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(pvalue_mean)
  min_num <- min(pvalue_mean)
  num<-pvalue_mean[col,]
  score <- (num - min_num) / (max_num - min_num)
  
  tmp <- data.frame(Method = col,value=score)
  pvalue_score <- rbind(pvalue_score,tmp)
}
pvalue_score$type <- "Real-world"
pvalue_score$type2 <-"pvalue"
##8、run and mem

data <- read.csv(file = "/~/memory_time_combined.csv", header = T)
data$Method <- gsub("CelFie","CelFiE",data$Method)

Mem <- aggregate(Memory.requirements~Method,data,mean)
row.names(Mem) <- Mem$Method
mem_score<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(Mem$Memory.requirements)
  min_num <- min(Mem$Memory.requirements)
  num<-Mem[col,"Memory.requirements"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score)
  mem_score <- rbind(mem_score,tmp)
}
mem_score$type <- "Usability"
mem_score$type2 <-"mem"
run <- aggregate(Run.time~Method,data,mean)
row.names(run) <- run$Method
run_score<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  max_num <- max(run$Run.time)
  min_num <- min(run$Run.time)
  num<-run[col,"Run.time"]
  score <- 1- (num - min_num) / (max_num - min_num)
  tmp <- data.frame(Method = col,value=score)
  run_score <- rbind(run_score,tmp)
}
run_score$type <- "Usability"
run_score$type2 <-"run"

all_df <- rbind(ACUOut,SampleOut,RefOut,MissOut,DepthOut,ctOut,auc_score,pvalue_score,mem_score,run_score)
all_out<-data.frame()
for (col in c("CelFEER", "CelFiE", "cfNOMe", "MethAtlas",  "UXM")) {
  df <- subset(all_df,Method == col)
  accuracy_value <- df %>%
    filter(type == "Accuracy") %>%
    mutate(value = value * 0.5)
  
  robustness_value <- df %>%
    filter(type == "Robustness") %>%
    summarise(value = mean(value) * 0.2) %>%
    ungroup()
  
  real_world_value <- df %>%
    filter(type == "Real-world") %>%
    summarise(value = mean(value) * 0.2) %>%
    ungroup()
  
  usability_value <- df %>%
    filter(type == "Usability") %>%
    summarise(value = mean(value) * 0.1) %>%
    ungroup()
  
  final_value <- accuracy_value$value + robustness_value$value + real_world_value$value + usability_value$value
  
  out_df <- data.frame(Method = col,Score = final_value)
  all_out<-rbind(all_out,out_df)
}

print(all_out)
