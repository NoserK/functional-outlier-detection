setwd('~/Desktop/fod/')

for(i in 1:20)
{ 
  
  # Load necessary packages
  library(fda)
  library(readxl)
  library(foreach)
  library(doParallel)
  source("~/Desktop/fod/TVD-master/R/TVD.R")
  numCores <- detectCores() - 1  # Leave one core free for other tasks
  registerDoParallel(numCores)
  
  #test
  extracted_features_with_prefixes_train <- read_excel("~/Desktop/fod/extracted_features_with_prefixes_alexnet_train.xlsx")
  extracted_features_with_prefixes_test <- read_excel("~/Desktop/fod/extracted_features_with_prefixes_alexnet_test.xlsx")
  
  data_Test1=subset(extracted_features_with_prefixes_test,ImageName=="Test001")
  data_Test2=subset(extracted_features_with_prefixes_test,ImageName=="Test002")
  data_Test3=subset(extracted_features_with_prefixes_test,ImageName=="Test003")
  data_Test4=subset(extracted_features_with_prefixes_test,ImageName=="Test004")
  data_Test5=subset(extracted_features_with_prefixes_test,ImageName=="Test005")
  data_Test6=subset(extracted_features_with_prefixes_test,ImageName=="Test006")
  data_Test7=subset(extracted_features_with_prefixes_test,ImageName=="Test007")
  data_Test8=subset(extracted_features_with_prefixes_test,ImageName=="Test008")
  data_Test9=subset(extracted_features_with_prefixes_test,ImageName=="Test009")
  data_Test10=subset(extracted_features_with_prefixes_test,ImageName=="Test010")
  data_Test11=subset(extracted_features_with_prefixes_test,ImageName=="Test011")
  data_Test12=subset(extracted_features_with_prefixes_test,ImageName=="Test012")
  
  
  data_train1=subset(extracted_features_with_prefixes_train,ImageName=="Train001")
  data_train2=subset(extracted_features_with_prefixes_train,ImageName=="Train002")
  data_train3=subset(extracted_features_with_prefixes_train,ImageName=="Train003")
  data_train4=subset(extracted_features_with_prefixes_train,ImageName=="Train004")
  data_train5=subset(extracted_features_with_prefixes_train,ImageName=="Train005")
  data_train6=subset(extracted_features_with_prefixes_train,ImageName=="Train006")
  data_train7=subset(extracted_features_with_prefixes_train,ImageName=="Train007")
  data_train8=subset(extracted_features_with_prefixes_train,ImageName=="Train008")
  data_train9=subset(extracted_features_with_prefixes_train,ImageName=="Train009")
  data_train10=subset(extracted_features_with_prefixes_train,ImageName=="Train010")
  data_train11=subset(extracted_features_with_prefixes_train,ImageName=="Train011")
  data_train12=subset(extracted_features_with_prefixes_train,ImageName=="Train012")
  data_train13=subset(extracted_features_with_prefixes_train,ImageName=="Train013")
  data_train14=subset(extracted_features_with_prefixes_train,ImageName=="Train014")
  data_train15=subset(extracted_features_with_prefixes_train,ImageName=="Train015")
  data_train16=subset(extracted_features_with_prefixes_train,ImageName=="Train016")
  
  # Create a new dataframe excluding the specified columns
  data_Test1<- subset(data_Test1, select = -c(`ImageName`))
  data_Test2<- subset(data_Test2, select = -c(`ImageName`))
  data_Test3<- subset(data_Test3, select = -c(`ImageName`))
  data_Test4<- subset(data_Test4, select = -c(`ImageName`))
  data_Test5<- subset(data_Test5, select = -c(`ImageName`))
  data_Test6<- subset(data_Test6, select = -c(`ImageName`))
  data_Test7<- subset(data_Test7, select = -c(`ImageName`))
  data_Test8<- subset(data_Test8, select = -c(`ImageName`))
  data_Test9<- subset(data_Test9, select = -c(`ImageName`))
  data_Test10<- subset(data_Test10, select = -c(`ImageName`))
  data_Test11<- subset(data_Test11, select = -c(`ImageName`))
  data_Test12<- subset(data_Test12, select = -c(`ImageName`))
  
  # Create a new dataframe excluding the specified columns
  data_train1<- subset(data_train1, select = -c(`ImageName`))
  data_train2<- subset(data_train2, select = -c(`ImageName`))
  data_train3<- subset(data_train3, select = -c(`ImageName`))
  data_train4<- subset(data_train4, select = -c(`ImageName`))
  data_train5<- subset(data_train5, select = -c(`ImageName`))
  data_train6<- subset(data_train6, select = -c(`ImageName`))
  data_train7<- subset(data_train7, select = -c(`ImageName`))
  data_train8<- subset(data_train8, select = -c(`ImageName`))
  data_train9<- subset(data_train9, select = -c(`ImageName`))
  data_train10<- subset(data_train10, select = -c(`ImageName`))
  data_train11<- subset(data_train11, select = -c(`ImageName`))
  data_train12<- subset(data_train12, select = -c(`ImageName`))
  data_train13<- subset(data_train13, select = -c(`ImageName`))
  data_train14<- subset(data_train14, select = -c(`ImageName`))
  data_train15<- subset(data_train15, select = -c(`ImageName`))
  data_train16<- subset(data_train16, select = -c(`ImageName`))
  
  mTest1=as.matrix(data_Test1)[fbplot(t(data_Test1),plot = F)$medcurve,]
  mTest2=as.matrix(data_Test2)[fbplot(t(data_Test2),plot = F)$medcurve,]
  mTest3=as.matrix(data_Test3)[fbplot(t(data_Test3),plot = F)$medcurve,]
  mTest4=as.matrix(data_Test4)[fbplot(t(data_Test4),plot = F)$medcurve,]
  mTest5=as.matrix(data_Test5)[fbplot(t(data_Test5),plot = F)$medcurve,]
  mTest6=as.matrix(data_Test6)[fbplot(t(data_Test6),plot = F)$medcurve,]
  mTest7=as.matrix(data_Test7)[fbplot(t(data_Test7),plot = F)$medcurve,]
  mTest8=as.matrix(data_Test8)[fbplot(t(data_Test8),plot = F)$medcurve,]
  mTest9=as.matrix(data_Test9)[fbplot(t(data_Test9),plot = F)$medcurve,]
  mTest10=as.matrix(data_Test10)[fbplot(t(data_Test10),plot = F)$medcurve,]
  mTest11=as.matrix(data_Test11)[fbplot(t(data_Test11),plot = F)$medcurve,]
  mTest12=as.matrix(data_Test12)[fbplot(t(data_Test12),plot = F)$medcurve,]
  
  data_train=subset(extracted_features_with_prefixes_train, select = -c(`ImageName`))
  
  
  selectnum=sample(x=c(1:2550),size = 160, replace = FALSE)
  mixed_train=data_train[selectnum,]
  assign(paste0("mtrain",i),
         as.matrix(mixed_train)[fbplot(t(mixed_train),plot = F)$medcurve,])
  k=dim(mixed_train)[1]
  y=matrix(0,nrow = k+1,ncol = 4096)
  
  y[1:k,]=as.matrix(mixed_train)-rep(1,k)%*%t(matrix(get(paste0("mtrain",i))))+matrix(0.0001*rnorm(k*4096),nrow = k,ncol = 4096)
  
  all_results <- foreach(test_ind = 1:12) %dopar% {
    n <- dim(get(paste0("data_Test", test_ind)))[1]
    resultd <- as.vector(rep(FALSE, n))
    resultf <- as.vector(rep(FALSE, n))
    rankresultd <- c()
    rankresultf <- c()
    
    for (m in 1:n) {
      y[k + 1, ] <- as.matrix(get(paste0("data_Test", test_ind))[m, ]) - 
        get(paste0("mTest", test_ind)) + 0.0001 * rnorm(4096, 0, 1)
      
      temp1 <- fbplot(t(y), factor = 0.01, plot = FALSE)
      resultf[m] <- ((k + 1) %in% temp1$outpoint)
      rankresultf[m] <- temp1$depth[k+1]
      
      temp2 <- detectOutlier(t(y), nCurve = k + 1, nPoint = 4096, 0.01)
      resultd[m] <- ((k + 1) %in% temp2$outlier)
      rankresultd[m] <- temp2$TVD[k+1]
    }
    rankresultf=rank(rankresultf)
    rankresultd=rank(rankresultd)
    cat("Finish loop of train", i, "test", test_ind, "\n")  
    list(resultd = resultd, resultf = resultf, rankresultd=rankresultd,rankresultf=rankresultf)
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
  write.table(df, file = "output_alexnet_mixed_1_100.csv", append = TRUE, col.names = !file.exists("output_alexnet_mixed_1_100.csv"), 
              row.names = FALSE)
  
  rm(list = ls())
  gc()
}