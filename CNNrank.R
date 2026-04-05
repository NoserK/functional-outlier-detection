setwd('~/Desktop/fod/')


for(i in 1:16)
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
  Embedded_InceptionV3_Tain_Images <- read_excel("~/Desktop/fod/Embedded_InceptionV3_Tain_Images.xlsx")
  Embedded_InceptionV3_Test_Images <- read_excel("~/Desktop/fod/Embedded_InceptionV3_Test_Images.xlsx")
  
  data_Test1=subset(Embedded_InceptionV3_Test_Images,category=="Test001")
  data_Test2=subset(Embedded_InceptionV3_Test_Images,category=="Test002")
  data_Test3=subset(Embedded_InceptionV3_Test_Images,category=="Test003")
  data_Test4=subset(Embedded_InceptionV3_Test_Images,category=="Test004")
  data_Test5=subset(Embedded_InceptionV3_Test_Images,category=="Test005")
  data_Test6=subset(Embedded_InceptionV3_Test_Images,category=="Test006")
  data_Test7=subset(Embedded_InceptionV3_Test_Images,category=="Test007")
  data_Test8=subset(Embedded_InceptionV3_Test_Images,category=="Test008")
  data_Test9=subset(Embedded_InceptionV3_Test_Images,category=="Test009")
  data_Test10=subset(Embedded_InceptionV3_Test_Images,category=="Test010")
  data_Test11=subset(Embedded_InceptionV3_Test_Images,category=="Test011")
  data_Test12=subset(Embedded_InceptionV3_Test_Images,category=="Test012")
  
  
  # Create a new dataframe excluding the specified columns
  data_Test1<- subset(data_Test1, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test2<- subset(data_Test2, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test3<- subset(data_Test3, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test4<- subset(data_Test4, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test5<- subset(data_Test5, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test6<- subset(data_Test6, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test7<- subset(data_Test7, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test8<- subset(data_Test8, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test9<- subset(data_Test9, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test10<- subset(data_Test10, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test11<- subset(data_Test11, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_Test12<- subset(data_Test12, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  
  data_train1=subset(Embedded_InceptionV3_Tain_Images,category=="Train001")
  data_train2=subset(Embedded_InceptionV3_Tain_Images,category=="Train002")
  data_train3=subset(Embedded_InceptionV3_Tain_Images,category=="Train003")
  data_train4=subset(Embedded_InceptionV3_Tain_Images,category=="Train004")
  data_train5=subset(Embedded_InceptionV3_Tain_Images,category=="Train005")
  data_train6=subset(Embedded_InceptionV3_Tain_Images,category=="Train006")
  data_train7=subset(Embedded_InceptionV3_Tain_Images,category=="Train007")
  data_train8=subset(Embedded_InceptionV3_Tain_Images,category=="Train008")
  data_train9=subset(Embedded_InceptionV3_Tain_Images,category=="Train009")
  data_train10=subset(Embedded_InceptionV3_Tain_Images,category=="Train010")
  data_train11=subset(Embedded_InceptionV3_Tain_Images,category=="Train011")
  data_train12=subset(Embedded_InceptionV3_Tain_Images,category=="Train012")
  data_train13=subset(Embedded_InceptionV3_Tain_Images,category=="Train013")
  data_train14=subset(Embedded_InceptionV3_Tain_Images,category=="Train014")
  data_train15=subset(Embedded_InceptionV3_Tain_Images,category=="Train015")
  data_train16=subset(Embedded_InceptionV3_Tain_Images,category=="Train016")
  
  
  # Create a new dataframe excluding the specified columns
  data_train1<- subset(data_train1, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train2<- subset(data_train2, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train3<- subset(data_train3, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train4<- subset(data_train4, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train5<- subset(data_train5, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train6<- subset(data_train6, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train7<- subset(data_train7, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train8<- subset(data_train8, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train9<- subset(data_train9, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train10<- subset(data_train10, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train11<- subset(data_train11, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train12<- subset(data_train12, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train13<- subset(data_train13, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train14<- subset(data_train14, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train15<- subset(data_train15, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  data_train16<- subset(data_train16, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
  
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
  
  assign(paste0("mtrain",i),
         as.matrix(get(paste0("data_train",i))[fbplot(t(get(paste0("data_train",i))),plot = F)$medcurve,]))
  k=dim(get(paste0("data_train",i)))[1]
  y=matrix(0,nrow = k+1,ncol = 2048)
  
  y[1:k,]=as.matrix(get(paste0("data_train",i)))-rep(1,k)%*%t(matrix(get(paste0("mtrain",i))))+matrix(0.0001*rnorm(k*2048),nrow = k,ncol = 2048)
  
  all_results <- foreach(test_ind = 1:12) %dopar% {
    n <- dim(get(paste0("data_Test", test_ind)))[1]
    resultd <- as.vector(rep(FALSE, n))
    resultf <- as.vector(rep(FALSE, n))
    
    for (m in 1:n) {
      y[k + 1, ] <- as.matrix(get(paste0("data_Test", test_ind))[m, ]) - 
        get(paste0("mTest", test_ind)) + 0.0001 * rnorm(2048, 0, 1)
      
      temp1 <- fbplot(t(y), factor = 3, plot = FALSE)
      resultf[m] <- ((k + 1) %in% temp1$outpoint)
      
      temp2 <- detectOutlier(t(y), nCurve = k + 1, nPoint = 2048, 3)
      resultd[m] <- ((k + 1) %in% temp2$outlier)
    }
    cat("Finish loop of train", i, "test", test_ind, "\n")  
    list(resultd = resultd, resultf = resultf, rankresultd=rank(resultd),rankresultf=rank(resultf))
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
      sum(all_results[[test_ind]]$rankresultd[groundTruth[[test_ind]]] <= 
            length(groundTruth[[test_ind]])) /length(groundTruth[[test_ind]])
    if (length(groundTruth[[test_ind]]) == 
        length(all_results[[test_ind]]$resultd)){
      temp_vector4[test_ind] <- 0
    } else {
      temp_vector4[test_ind] <- 
        sum(all_results[[test_ind]]$rankresultd[-groundTruth[[test_ind]]] >= (length(groundTruth[[test_ind]]))) /
        (length(all_results[[test_ind]]$resultd) - 
           length(groundTruth[[test_ind]]))
    }
  }
  assign(vector_name3, temp_vector3)
  assign(vector_name4, temp_vector4)
  df <- data.frame(var0 = c(get(paste0("tpr", i)), get(paste0("fpr", i))))
  names(df) <- c(paste0("Train", i))
  write.table(df, file = "output_cnnr.csv", append = TRUE, col.names = !file.exists("output_cnnr.csv"), 
              row.names = FALSE)
  
  rm(list = ls())
  gc()
}
