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

vftrain<-c()
vdtrain<-c()

vftest<-c()
vdtest<-c()

for(i in 1:16)
{
  k=dim(get(paste0("data_train",i)))[1]
  vftrain[i]=var(fbplot(t(get(paste0("data_train",i))),plot = F)$depth)*k/180
  vdtrain[i]=var(detectOutlier(t(get(paste0("data_train",i))), nCurve = k, nPoint = 2048, 3)$TVD)*k/180
  
}

for(j in 1:12)
{
  k=dim(get(paste0("data_Test",j)))[1]
  vftest[j]=var(fbplot(t(get(paste0("data_Test",j))),plot = F)$depth)*k/180
  vdtest[j]=var(detectOutlier(t(get(paste0("data_Test",j))), nCurve = k, nPoint = 2048, 3)$TVD)*k/180
}

