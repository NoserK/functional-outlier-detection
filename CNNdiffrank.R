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
  
  k=dim(get(paste0("data_train",i)))[1]
  assign(paste0("dtrain",i),
         as.matrix(get(paste0("data_train",i))[c(1:(k-1)),])-as.matrix(get(paste0("data_train",i))[c(2:k),]))
  y=matrix(0,nrow = k,ncol = 2048)
  
  y[1:(k-1),]=as.matrix(get(paste0("dtrain",i)))
  
  all_results <- foreach(test_ind = 1:12) %dopar% {
    n <- dim(get(paste0("data_Test", test_ind)))[1]
    assign(paste0("dtest",test_ind),
           as.matrix(get(paste0("data_Test",test_ind))[c(1:(n-1)),])-as.matrix(get(paste0("data_Test",test_ind))[c(2:n),]))
    resultd <- as.vector(rep(FALSE, n))
    resultf <- as.vector(rep(FALSE, n))
    
    for (m in 1:(n-1)) {
      y[k, ] <- as.matrix(get(paste0("dtest", test_ind))[m, ])
      
      temp1 <- fbplot(t(y), factor = 3, plot = FALSE)
      resultf[m] <- (k %in% temp1$outpoint)
      
      temp2 <- detectOutlier(t(y), nCurve = k, nPoint = 2048, 3)
      resultd[m] <- (k %in% temp2$outlier)
    }
    cat("Finish loop of train", i, "test", test_ind, "\n")  
    list(resultd = resultd, resultf = resultf, rankresultd=rank(resultd),rankresultf=rank(resultf))
  }
  
  # AUCROC
  
  groundTruth <- list()
  groundTruth[[1]] <- c(60:179)
  groundTruth[[2]] <- c(94:179)
  groundTruth[[3]] <- c(1:146)
  groundTruth[[4]] <- c(30:179)
  groundTruth[[5]] <- c(1:129)
  groundTruth[[6]] <- c(1:159)
  groundTruth[[7]] <- c(45:179)
  groundTruth[[8]] <- c(1:179)
  groundTruth[[9]] <- c(1:119)
  groundTruth[[10]] <- c(1:149)
  groundTruth[[11]] <- c(1:179)
  groundTruth[[12]] <- c(87:179)
  
  assign(paste0("tpr",i),as.vector(rep(0,12)))
  assign(paste0("fpr",i),as.vector(rep(0,12)))
  
  vector_name3 <- paste0("tpr", i)
  temp_vector3 <- get(vector_name3)
  vector_name4 <- paste0("fpr", i)
  temp_vector4 <- get(vector_name4)
  for (test_ind in 1:12){
    temp_vector3[test_ind] <- 
      sum(all_results[[test_ind]]$rankresultd[groundTruth[[test_ind]]] <= 
            length(groundTruth[[test_ind]])) #/length(groundTruth[[test_ind]])
    if (length(groundTruth[[test_ind]]) == 
        length(all_results[[test_ind]]$resultd)){
      temp_vector4[test_ind] <- 0
    } else {
      temp_vector4[test_ind] <- 
        sum(all_results[[test_ind]]$rankresultd[-groundTruth[[test_ind]]] >= (length(groundTruth[[test_ind]]))) #/
        #(length(all_results[[test_ind]]$resultd) - 
           #length(groundTruth[[test_ind]]))
    }
  }
  assign(vector_name3, temp_vector3)
  assign(vector_name4, temp_vector4)
  df <- data.frame(var0 = c(get(paste0("tpr", i)), get(paste0("fpr", i))))
  names(df) <- c(paste0("Train", i))
  write.table(df, file = "output_rank_cnndiff.csv", append = TRUE, col.names = !file.exists("output_rank_cnndiff.csv"), 
              row.names = FALSE)
  
  rm(list = ls())
  gc()
}