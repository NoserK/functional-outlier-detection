setwd('~/Desktop/fod/')


for(i in 1:16)
{
  # Load necessary packages
  library(fda)
  library(readxl)
  library(foreach)
  library(doParallel)
  source("~/Desktop/fod/TVD-master/R/TVD.R")
  numCores <- detectCores() - 2  # Leave one core free for other tasks
  registerDoParallel(numCores)
  
  test_features_1 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test001/test_features_1.xlsx")
  test_features_2 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test002/test_features_2.xlsx")
  test_features_3 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test003/test_features_3.xlsx")
  test_features_4 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test004/test_features_4.xlsx")
  test_features_5 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test005/test_features_5.xlsx")
  test_features_6 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test006/test_features_6.xlsx")
  test_features_7 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test007/test_features_7.xlsx")
  test_features_8 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test008/test_features_8.xlsx")
  test_features_9 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test009/test_features_9.xlsx")
  test_features_10 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test010/test_features_10.xlsx")
  test_features_11 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test011/test_features_11.xlsx")
  test_features_12 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test012/test_features_12.xlsx")

  
  data_Test1=test_features_1
  data_Test2=test_features_2
  data_Test3=test_features_3
  data_Test4=test_features_4
  data_Test5=test_features_5
  data_Test6=test_features_6
  data_Test7=test_features_7
  data_Test8=test_features_8
  data_Test9=test_features_9
  data_Test10=test_features_10
  data_Test11=test_features_11
  data_Test12=test_features_12
  
  
  # Create a new dataframe excluding the specified columns
  train_features_1 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train001/train_features_1.xlsx")
  train_features_2 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train002/train_features_2.xlsx")
  train_features_3 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train003/train_features_3.xlsx")
  train_features_4 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train004/train_features_4.xlsx")
  train_features_5 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train005/train_features_5.xlsx")
  train_features_6 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train006/train_features_6.xlsx")
  train_features_7 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train007/train_features_7.xlsx")
  train_features_8 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train008/train_features_8.xlsx")
  train_features_9 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train009/train_features_9.xlsx")
  train_features_10 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train010/train_features_10.xlsx")
  train_features_11 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train011/train_features_11.xlsx")
  train_features_12 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train012/train_features_12.xlsx")
  train_features_13 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train013/train_features_13.xlsx")
  train_features_14 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train014/train_features_14.xlsx")
  train_features_15 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train015/train_features_15.xlsx")
  train_features_16 <- read_excel("~/Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/train_features_16.xlsx")
  
  data_train1 <- train_features_1
  data_train2 <- train_features_2
  data_train3 <- train_features_3
  data_train4 <- train_features_4
  data_train5 <- train_features_5
  data_train6 <- train_features_6
  data_train7 <- train_features_7
  data_train8 <- train_features_8
  data_train9 <- train_features_9
  data_train10 <- train_features_10
  data_train11 <- train_features_11
  data_train12 <- train_features_12
  data_train13 <- train_features_13
  data_train14 <- train_features_14
  data_train15 <- train_features_15
  data_train16 <- train_features_16
  
  k=dim(get(paste0("data_train",i)))[1]
  y=matrix(0,nrow = k+1,ncol = 4096)
  
  y[1:k,]=as.matrix(get(paste0("data_train",i)))
  
  all_results <- foreach(test_ind = 1:12) %dopar% {
    n <- dim(get(paste0("data_Test", test_ind)))[1]
    resultd <- as.vector(rep(FALSE, n))
    resultf <- as.vector(rep(FALSE, n))
    
    for (m in 1:n) {
      y[k + 1, ] <- as.matrix(get(paste0("data_Test", test_ind))[m, ]) 
      
      temp1 <- fbplot(t(y), factor = 3, plot = FALSE)
      resultf[m] <- ((k + 1) %in% temp1$outpoint)
      
      temp2 <- detectOutlier(t(y), nCurve = k + 1, nPoint = 4096, 3)
      resultd[m] <- ((k + 1) %in% temp2$outlier)
    }
    cat("Finish loop of train", i, "test", test_ind, "\n")  
    list(resultd = resultd, resultf = resultf)
  }
  
  # AUCROC
  
  groundTruth <- list()
  groundTruth[[1]] <- c(61:180)
  groundTruth[[2]] <- c(95:180)
  groundTruth[[3]] <- c(1:146)
  groundTruth[[4]] <- c(31:180)
  groundTruth[[5]] <- c(1:129)
  groundTruth[[6]] <- c(1:159)
  groundTruth[[7]] <- c(46:180)
  groundTruth[[8]] <- c(1:180)
  groundTruth[[9]] <- c(1:120)
  groundTruth[[10]] <- c(1:150)
  groundTruth[[11]] <- c(1:180)
  groundTruth[[12]] <- c(88:180)
  
  assign(paste0("tpr",i),as.vector(rep(0,12)))
  assign(paste0("fpr",i),as.vector(rep(0,12)))
  
  vector_name3 <- paste0("tpr", i)
  temp_vector3 <- get(vector_name3)
  vector_name4 <- paste0("fpr", i)
  temp_vector4 <- get(vector_name4)
  for (test_ind in 1:12){
    temp_vector3[test_ind] <- 
      sum(all_results[[test_ind]]$resultd[groundTruth[[test_ind]]] == TRUE) /
      length(groundTruth[[test_ind]])
    if (length(groundTruth[[test_ind]]) == 
        length(all_results[[test_ind]]$resultd)){
      temp_vector4[test_ind] <- 0
    } else {
      temp_vector4[test_ind] <- 
        sum(all_results[[test_ind]]$resultd[-groundTruth[[test_ind]]] == TRUE) /
        (length(all_results[[test_ind]]$resultd) - 
           length(groundTruth[[test_ind]]))
    }
  }
  assign(vector_name3, temp_vector3)
  assign(vector_name4, temp_vector4)
  df <- data.frame(var0 = c(get(paste0("tpr", i)), get(paste0("fpr", i))))
  names(df) <- c(paste0("Train", i))
  write.table(df, file = "output_alexnet_mean.csv", append = TRUE, col.names = !file.exists("output_alexnet_mean.csv"), 
              row.names = FALSE)
  
  rm(list = ls())
  gc()
}

