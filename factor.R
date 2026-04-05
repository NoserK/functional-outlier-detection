library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train010/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train010 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(train010[[i]])
}

fbplot(fit = t(x),factor=1000000, ,plot = T)


library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train001 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train001[[i]])
}

fbplot(fit = t(x),factor=100, ,plot = T)

z=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  z[i,]=as.vector(train001[[i]])-as.vector(train001[[46]])
}

fbplot(fit = t(z),factor=100, ,plot = T)



result1=detectOutlier(t(x),120,240*360,3)

mss1=result1$MSS
tvd1=result1$TVD
outlier1=result1$outlier
sout1=result1$sOut
mout1=result1$mOut

for(j in 1:60)
{
  y=x[,1:1440+1440*(j-1)]
  fbplot(fit = t(y),factor = 100,plot = T)
}

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train002 <- stack(tif_files)

x=matrix(0,nrow = 150,ncol = 240*360)

for(i in 1:150)
{
  x[i,]=as.vector(train002[[i]])
}

fbplot(fit = t(x),factor=100, ,plot = T)

result2=detectOutlier(t(x),150,240*360,3)

mss2=result2$MSS
tvd2=result2$TVD
outlier2=result2$outlier
sout2=result2$sOut
mout2=result2$mOut

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train003/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train003 <- stack(tif_files)

x=matrix(0,nrow = 150,ncol = 240*360)

for(i in 1:150)
{
  x[i,]=as.vector(train003[[i]])
}

fbplot(fit = t(x),factor=100, ,plot = T)

result3=detectOutlier(t(x),150,240*360,100)

mss3=result3$MSS
tvd3=result3$TVD
outlier3=result3$outlier
sout3=result3$sOut
mout3=result3$mOut




#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)

#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)

#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train016/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train016 <- stack(tif_files)

x=matrix(0,nrow = 120,ncol = 240*360)

for(i in 1:120)
{
  x[i,]=as.vector(train016[[i]])
}

fbplot(fit = x,factor=0.4134,plot = F)

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
data_train3<- subset(data_train4, select = -c(`category`,`image name`,`image`,`size`,`width`,`height`))
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

library(fda)
fbplot(fit = t(data_train1),factor=4.375,plot = T)
fbplot(fit = t(data_train2),factor=100,plot = T)
fbplot(fit = t(data_train3),factor=3.5,plot = T)
fbplot(fit = t(data_train4),factor=6.25,plot = T)
fbplot(fit = t(data_train5),factor=3.125,plot = T)
fbplot(fit = t(data_train6),factor=3,plot = T)
fbplot(fit = t(data_train7),factor=2.875,plot = T)
fbplot(fit = t(data_train8),factor=4.375,plot = T)
fbplot(fit = t(data_train9),factor=3.375,plot = T)
fbplot(fit = t(data_train10),factor=3.125,plot = T)
fbplot(fit = t(data_train11),factor=2.625,plot = T)
fbplot(fit = t(data_train12),factor=3.625,plot = T)
fbplot(fit = t(data_train13),factor=6.625,plot = T)
fbplot(fit = t(data_train14),factor=5.375,plot = T)
fbplot(fit = t(data_train15),factor=2.375,plot = T)
fbplot(fit = t(data_train16),factor=4.875,plot = T)


#test

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


library(fda)
resultf1=fbplot(fit = t(data_Test1),factor=3,plot = T)
resultf2=fbplot(fit = t(data_Test2),factor=3,plot = T)
resultf3=fbplot(fit = t(data_Test3),factor=3,plot = T)
resultf4=fbplot(fit = t(data_Test4),factor=3,plot = T)
resultf5=fbplot(fit = t(data_Test5),factor=3,plot = T)
resultf6=fbplot(fit = t(data_Test6),factor=3,plot = T)
resultf7=fbplot(fit = t(data_Test7),factor=3,plot = T)
resultf8=fbplot(fit = t(data_Test8),factor=3,plot = T)
resultf9=fbplot(fit = t(data_Test9),factor=3,plot = T)
resultf10=fbplot(fit = t(data_Test10),factor=3,plot = T)
resultf11=fbplot(fit = t(data_Test11),factor=3,plot = T)
resultf12=fbplot(fit = t(data_Test12),factor=3,plot = T)


resultd1=detectOutlier(data = t(data_Test1),nCurve = dim(data_Test1)[1],nPoint = dim(data_Test1)[2],empFactor = 3)
resultd2=detectOutlier(data = t(data_Test2),nCurve = dim(data_Test2)[1],nPoint = dim(data_Test2)[2],empFactor = 3)
resultd3=detectOutlier(data = t(data_Test3),nCurve = dim(data_Test3)[1],nPoint = dim(data_Test3)[2],empFactor = 3)
resultd4=detectOutlier(data = t(data_Test4),nCurve = dim(data_Test4)[1],nPoint = dim(data_Test4)[2],empFactor = 3)
resultd5=detectOutlier(data = t(data_Test5),nCurve = dim(data_Test5)[1],nPoint = dim(data_Test5)[2],empFactor = 3)
resultd6=detectOutlier(data = t(data_Test6),nCurve = dim(data_Test6)[1],nPoint = dim(data_Test6)[2],empFactor = 3)
resultd7=detectOutlier(data = t(data_Test7),nCurve = dim(data_Test7)[1],nPoint = dim(data_Test7)[2],empFactor = 3)
resultd8=detectOutlier(data = t(data_Test8),nCurve = dim(data_Test8)[1],nPoint = dim(data_Test8)[2],empFactor = 3)
resultd9=detectOutlier(data = t(data_Test9),nCurve = dim(data_Test9)[1],nPoint = dim(data_Test9)[2],empFactor = 3)
resultd10=detectOutlier(data = t(data_Test10),nCurve = dim(data_Test10)[1],nPoint = dim(data_Test10)[2],empFactor = 3)
resultd11=detectOutlier(data = t(data_Test11),nCurve = dim(data_Test11)[1],nPoint = dim(data_Test11)[2],empFactor = 3)
resultd12=detectOutlier(data = t(data_Test12),nCurve = dim(data_Test12)[1],nPoint = dim(data_Test12)[2],empFactor = 3)

#1

resultd1$outlier
resultf1$outlier
max(resultd1$TVD[1:60])
max(resultd1$TVD[61:180])

min(resultf1$depth[1:60])
max(resultf1$depth[1:60])
max(resultf1$depth[61:180])

#2

resultd2$outlier
resultf2$outlier
min(resultd2$TVD[1:94])
max(resultd2$TVD[1:94])
max(resultd2$TVD[95:180])

min(resultf2$depth[1:94])
max(resultf2$depth[1:94])
max(resultf2$depth[95:180])

#4

resultd4$outlier
resultf4$outlier
min(resultd4$TVD[1:30])
max(resultd4$TVD[1:30])
max(resultd4$TVD[31:180])

min(resultf4$depth[1:30])
max(resultf4$depth[1:30])
max(resultf4$depth[31:180])

#5

resultd5$outlier
resultf5$outlier
min(resultd5$TVD[130:150])
max(resultd5$TVD[1:129])
max(resultd5$TVD[130:150])

min(resultf5$depth[130:150])
max(resultf5$depth[1:129])
max(resultf5$depth[130:150])

#6

resultd6$outlier
resultf6$outlier
min(resultd6$TVD[160:180])
max(resultd6$TVD[1:159])
max(resultd6$TVD[160:180])

min(resultf6$depth[160:180])
max(resultf6$depth[1:159])
max(resultf6$depth[160:180])

#7

resultd7$outlier
resultf7$outlier
min(resultd7$TVD[1:45])
max(resultd7$TVD[1:45])
max(resultd7$TVD[46:180])

min(resultf7$depth[1:45])
max(resultf7$depth[1:45])
max(resultf7$depth[46:180])

#12

resultd12$outlier
resultf12$outlier
min(resultd12$TVD[1:87])
max(resultd12$TVD[1:87])
max(resultd12$TVD[88:180])

min(resultf12$depth[1:87])
max(resultf12$depth[1:87])
max(resultf12$depth[88:180])

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test001 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test001[[i]])
}

resultf1r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd1r=detectOutlier(t(x),180,240*360,3)

outlierf1r=resultf1r$outpoint
outlierd1r=resultd1r$outlier
fd1=resultf1$depth
td1=resultd1r$TVD

min(fd1[1:60])
max(fd1[61:180])

min(td1[1:60])
max(td1[1:60])
max(td1[61:180])

#2

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test002 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test002[[i]])
}

resultf2r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd2r=detectOutlier(t(x),180,240*360,3)

outlierf2r=resultf2r$outpoint
outlierd2r=resultd2r$outlier
fd2=resultf2r$depth
td2=resultd2r$TVD

min(fd1[1:94])
max(fd1[95:180])

min(td2[1:94])
max(td2[1:94])
max(td2[95:180])

#4

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test004/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test004 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test004[[i]])
}

resultf4r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd4r=detectOutlier(t(x),180,240*360,3)

outlierf4r=resultf4r$outpoint
outlierd4r=resultd4r$outlier
fd4=resultf4r$depth
td4=resultd4r$TVD

min(fd4[1:30])
max(fd4[31:180])

min(td4[1:30])
max(td4[1:30])
max(td4[31:180])

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test003/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test003 <- stack(tif_files)

x=matrix(0,nrow = 150,ncol = 240*360)

for(i in 1:150)
{
  x[i,]=as.vector(test003[[i]])
}

resultf3r=fbplot(fit = t(x),factor=100, ,plot = F)

resultd3r=detectOutlier(t(x),150,240*360,3)

outlierf3r=resultf3r$outpoint
outlierd3r=resultd3r$outlier
fd3=resultf3$depth
td3=resultd3r$TVD

min(fd1[147:150])
max(fd1[1:146])

min(td1[147:150])
max(td1[147:150])
max(td1[1:146])

#5

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test005/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test005 <- stack(tif_files)

x=matrix(0,nrow = 150,ncol = 240*360)

for(i in 1:150)
{
  x[i,]=as.vector(test005[[i]])
}

resultf5r=fbplot(fit = t(x),factor=100, ,plot = F)

resultd5r=detectOutlier(t(x),150,240*360,3)

outlierf5r=resultf5r$outpoint
outlierd5r=resultd5r$outlier
fd5=resultf5r$depth
td5=resultd5r$TVD

min(fd5[1:129])
max(fd5[130:150])

min(td2[1:129])
max(td2[1:129])
max(td2[130:150])

#6

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test006/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test006 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test006[[i]])
}

resultf6r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd6r=detectOutlier(t(x),180,240*360,3)

outlierf6r=resultf6r$outpoint
outlierd6r=resultd6r$outlier
fd6=resultf6r$depth
td6=resultd6r$TVD

min(fd6[1:45])
max(fd6[46:180])

min(td6[1:45])
max(td6[1:45])
max(td6[46:180])

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test007/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test007 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test007[[i]])
}

resultf1r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd1r=detectOutlier(t(x),180,240*360,3)

outlierf7r=resultf7r$outpoint
outlierd7r=resultd7r$outlier
fd1=resultf1$depth
td1=resultd1r$TVD

min(fd1[1:60])
max(fd1[61:180])

min(td1[1:60])
max(td1[1:60])
max(td1[61:180])

#2

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Train/Train002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train002 <- stack(tif_files)

x=matrix(0,nrow = 150,ncol = 240*360)

for(i in 1:150)
{
  x[i,]=as.vector(train002[[i]])
}

resulttrainf2r=fbplot(fit = t(x),factor=100, ,plot = T)

resulttraind2r=detectOutlier(t(x),150,240*360,3)

outlierf2r=resulttrainf2r$outpoint
outlierd2r=resulttraind2r$outlier
trainfd2=resulttrainf2r$depth
traintd2=resulttraind2r$TVD
min(traintm2)
min(trainfd2)
min(traintd2)
traintm2=resulttraind2r$MSS



#4

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test004/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test004 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test004[[i]])
}

resultf4r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd4r=detectOutlier(t(x),180,240*360,3)

outlierf4r=resultf4r$outpoint
outlierd4r=resultd4r$outlier
fd4=resultf4r$depth
td4=resultd4r$TVD

min(fd4[1:30])
max(fd4[31:180])

min(td4[1:30])
max(td4[1:30])
max(td4[31:180])

library(raster)
library(fda)
#train

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test001 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test001[[i]])
}

resultf1r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd1r=detectOutlier(t(x),180,240*360,3)

outlierf1r=resultf1r$outpoint
outlierd1r=resultd1r$outlier
fd1=resultf1$depth
td1=resultd1r$TVD

min(fd1[1:60])
max(fd1[61:180])

min(td1[1:60])
max(td1[1:60])
max(td1[61:180])

#2

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test002 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test002[[i]])
}

resultf2r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd2r=detectOutlier(t(x),180,240*360,3)

outlierf2r=resultf2r$outpoint
outlierd2r=resultd2r$outlier
fd2=resultf2r$depth
td2=resultd2r$TVD

min(fd1[1:94])
max(fd1[95:180])

min(td2[1:94])
max(td2[1:94])
max(td2[95:180])

#4

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped2/Test/Test004/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test004 <- stack(tif_files)

x=matrix(0,nrow = 180,ncol = 240*360)

for(i in 1:180)
{
  x[i,]=as.vector(test004[[i]])
}

resultf4r=fbplot(fit = t(x),factor=100, ,plot = T)

resultd4r=detectOutlier(t(x),180,240*360,3)

outlierf4r=resultf4r$outpoint
outlierd4r=resultd4r$outlier
fd4=resultf4r$depth
td4=resultd4r$TVD

min(fd4[1:30])
max(fd4[31:180])

min(td4[1:30])
max(td4[1:30])
max(td4[31:180])

mmtrain=(as.matrix(data_train1)[fbplot(t(data_train1),plot = F)$medcurve,]+as.matrix(data_train2)[fbplot(t(data_train2),plot = F)$medcurve,]+as.matrix(data_train4)[fbplot(t(data_train4),plot = F)$medcurve,]+as.matrix(data_train4)[fbplot(t(data_train4),plot = F)$medcurve,]+as.matrix(data_train5)[fbplot(t(data_train5),plot = F)$medcurve,]+as.matrix(data_train6)[fbplot(t(data_train6),plot = F)$medcurve,]+as.matrix(data_train7)[fbplot(t(data_train7),plot = F)$medcurve,]+as.matrix(data_train8)[fbplot(t(data_train8),plot = F)$medcurve,]+as.matrix(data_train9)[fbplot(t(data_train9),plot = F)$medcurve,]+as.matrix(data_train10)[fbplot(t(data_train10),plot = F)$medcurve,]+as.matrix(data_train11)[fbplot(t(data_train11),plot = F)$medcurve,]+as.matrix(data_train12)[fbplot(t(data_train12),plot = F)$medcurve,]+as.matrix(data_train13)[fbplot(t(data_train13),plot = F)$medcurve,]+as.matrix(data_train14)[fbplot(t(data_train14),plot = F)$medcurve,]+as.matrix(data_train15)[fbplot(t(data_train15),plot = F)$medcurve,]+as.matrix(data_train16)[fbplot(t(data_train16),plot = F)$medcurve,])/16
mtrain1=as.matrix(data_train1)[fbplot(t(data_train1),plot = F)$medcurve,]
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


#Test 1 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf11=c()
resultd11=c()
mf11=c()
mdt11=c()
mdm11=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test1[i,])-mTest1+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf11[i]=(121 %in% temp1$outpoint)
  mf11[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd11[i]=(121 %in% temp2$outlier)
  mdt11[i]=temp2$TVD[121]
  mdm11[i]=temp2$MSS[121]
}

#Test 2 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf12=c()
resultd12=c()
mf12=c()
mdt12=c()
mdm12=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test2[i,])-mTest2+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf12[i]=(121 %in% temp1$outpoint)
  mf12[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd12[i]=(121 %in% temp2$outlier)
  mdt12[i]=temp2$TVD[121]
  mdm12[i]=temp2$MSS[121]
}

#Test 3 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf13=c()
resultd13=c()
mf13=c()
mdt13=c()
mdm13=c()

for(i in 1:150)
{
  y[121,]=as.matrix(data_Test3[i,])-mTest3+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf13[i]=(121 %in% temp1$outpoint)
  mf13[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd13[i]=(121 %in% temp2$outlier)
  mdt13[i]=temp2$TVD[121]
  mdm13[i]=temp2$MSS[121]
}

#Test 4 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf14=c()
resultd14=c()
mf14=c()
mdt14=c()
mdm14=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test4[i,])-mTest4+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf14[i]=(121 %in% temp1$outpoint)
  mf14[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd14[i]=(121 %in% temp2$outlier)
  mdt14[i]=temp2$TVD[121]
  mdm14[i]=temp2$MSS[121]
}

#Test 5 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf15=c()
resultd15=c()
mf15=c()
mdt15=c()
mdm15=c()

for(i in 1:150)
{
  y[121,]=as.matrix(data_Test5[i,])-mTest5+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf15[i]=(121 %in% temp1$outpoint)
  mf15[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd15[i]=(121 %in% temp2$outlier)
  mdt15[i]=temp2$TVD[121]
  mdm15[i]=temp2$MSS[121]
}

#Test 6 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf16=c()
resultd16=c()
mf16=c()
mdt16=c()
mdm16=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test6[i,])-mTest6+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf16[i]=(121 %in% temp1$outpoint)
  mf16[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd16[i]=(121 %in% temp2$outlier)
  mdt16[i]=temp2$TVD[121]
  mdm16[i]=temp2$MSS[121]
}

#Test 7 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf17=c()
resultd17=c()
mf17=c()
mdt17=c()
mdm17=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test7[i,])-mTest7+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf17[i]=(121 %in% temp1$outpoint)
  mf17[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd17[i]=(121 %in% temp2$outlier)
  mdt17[i]=temp2$TVD[121]
  mdm17[i]=temp2$MSS[121]
}

#Test 8 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf18=c()
resultd18=c()
mf18=c()
mdt18=c()
mdm18=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test8[i,])-mTest8+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf18[i]=(121 %in% temp1$outpoint)
  mf18[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd18[i]=(121 %in% temp2$outlier)
  mdt18[i]=temp2$TVD[121]
  mdm18[i]=temp2$MSS[121]
}

#Test 9 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf19=c()
resultd19=c()
mf19=c()
mdt19=c()
mdm19=c()

for(i in 1:120)
{
  y[121,]=as.matrix(data_Test9[i,])-mTest9+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf19[i]=(121 %in% temp1$outpoint)
  mf19[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd19[i]=(121 %in% temp2$outlier)
  mdt19[i]=temp2$TVD[121]
  mdm19[i]=temp2$MSS[121]
}

#Test 10 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf110=c()
resultd110=c()
mf110=c()
mdt110=c()
mdm110=c()

for(i in 1:150)
{
  y[121,]=as.matrix(data_Test1[i,])-mTest10+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf110[i]=(121 %in% temp1$outpoint)
  mf110[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd110[i]=(121 %in% temp2$outlier)
  mdt110[i]=temp2$TVD[121]
  mdm110[i]=temp2$MSS[121]
}

#Test 11 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf111=c()
resultd111=c()
mf111=c()
mdt111=c()
mdm111=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test11[i,])-mTest11+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf111[i]=(121 %in% temp1$outpoint)
  mf111[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd111[i]=(121 %in% temp2$outlier)
  mdt111[i]=temp2$TVD[121]
  mdm111[i]=temp2$MSS[121]
}

#Test 12 to Train 1 CNN

y=matrix(0,nrow = 121,ncol = 2048)

y[1:120,]=as.matrix(data_train1)-rep(1,120)%*%t(mtrain1)+matrix(0.0001*rnorm(120*2048),nrow = 120,ncol = 2048)

resultf112=c()
resultd112=c()
mf112=c()
mdt112=c()
mdm112=c()

for(i in 1:180)
{
  y[121,]=as.matrix(data_Test1[i,])-mTest12+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf112[i]=(121 %in% temp1$outpoint)
  mf112[i]=temp1$depth[121]
  temp2=TVDMSS(t(y),nCurve = 121,nPoint = 2048)
  resultd112[i]=(121 %in% temp2$outlier)
  mdt112[i]=temp2$TVD[121]
  mdm112[i]=temp2$MSS[121]
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

fpr1 <- tpr1 <- 0;
for (i in 1:12){
  fpr1[i] <- sum(get(paste0("resultd1",i))[groundTruth[[i]]] == FALSE) /
    length(groundTruth[[i]])
  if (length(groundTruth[[i]]) == 
      length(get(paste0("resultd1",i)))){
    tpr1[i] <- 1
  }
  else{
    tpr1[i] <- sum(get(paste0("resultd1",i))[-groundTruth[[i]]] == FALSE) /
      (length(get(paste0("resultd1",i))) - length(groundTruth[[i]]))
  }
}


tpr1
fpr1

#Train 3

mtrain3=as.matrix(data_train3)[fbplot(t(data_train3),plot = F)$medcurve,]
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


#Test 1 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf31=c()
resultd31=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test1[i,])-mTest1+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf31[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd31[i]=(151 %in% temp2$outlier)
}

#Test 2 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf32=c()
resultd32=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test2[i,])-mTest2+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf32[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd32[i]=(151 %in% temp2$outlier)
}

#Test 3 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf33=c()
resultd33=c()

for(i in 1:150)
{
  y[151,]=as.matrix(data_Test3[i,])-mTest3+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf33[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd33[i]=(151 %in% temp2$outlier)
}

#Test 4 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf34=c()
resultd34=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test4[i,])-mTest4+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf34[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd34[i]=(151 %in% temp2$outlier)
}

#Test 5 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf35=c()
resultd35=c()

for(i in 1:150)
{
  y[151,]=as.matrix(data_Test5[i,])-mTest5+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf35[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd35[i]=(151 %in% temp2$outlier)
}

#Test 6 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf36=c()
resultd36=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test6[i,])-mTest6+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf36[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd36[i]=(151 %in% temp2$outlier)
}

#Test 7 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf37=c()
resultd37=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test7[i,])-mTest7+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf37[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd37[i]=(151 %in% temp2$outlier)
}

#Test 8 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf38=c()
resultd38=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test8[i,])-mTest8+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf38[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd38[i]=(151 %in% temp2$outlier)
}

#Test 9 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf39=c()
resultd39=c()

for(i in 1:120)
{
  y[151,]=as.matrix(data_Test9[i,])-mTest9+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf39[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd39[i]=(151 %in% temp2$outlier)
}

#Test 10 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf310=c()
resultd310=c()

for(i in 1:150)
{
  y[151,]=as.matrix(data_Test1[i,])-mTest10+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf310[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd310[i]=(151 %in% temp2$outlier)
}

#Test 11 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf311=c()
resultd311=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test11[i,])-mTest11+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf311[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd311[i]=(151 %in% temp2$outlier)
}


#Test 12 to Train 1 CNN

y=matrix(0,nrow = 151,ncol = 2048)

y[1:150,]=as.matrix(data_train3)-rep(1,150)%*%t(mtrain3)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf312=c()
resultd312=c()

for(i in 1:180)
{
  y[151,]=as.matrix(data_Test1[i,])-mTest12+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf312[i]=(151 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 151,nPoint = 2048)
  resultd312[i]=(151 %in% temp2$outlier)
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

fpr3 <- tpr3 <- 0;
for (i in 1:12){
  fpr3[i] <- sum(get(paste0("resultd3",i))[groundTruth[[i]]] == FALSE) /
    length(groundTruth[[i]])
  if (length(groundTruth[[i]]) == 
      length(get(paste0("resultd3",i)))){
    tpr3[i] <- 1
  }
  else{
    tpr3[i] <- sum(get(paste0("resultd3",i))[-groundTruth[[i]]] == FALSE) /
      (length(get(paste0("resultd3",i))) - length(groundTruth[[i]]))
  }
}


#Train 4

mtrain4=as.matrix(data_train4)[fbplot(t(data_train4),plot = F)$medcurve,]
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


#Test 1 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:150,]=as.matrix(data_train4)-rep(1,150)%*%t(mtrain4)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf41=c()
resultd41=c()
mf31=c()
mdt31=c()
mdm31=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test1[i,])-mTest1+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf41[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd41[i]=(181 %in% temp2$outlier)
}

#Test 2 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 150,ncol = 2048)

resultf42=c()
resultd42=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test2[i,])-mTest2+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf42[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd42[i]=(181 %in% temp2$outlier)
}

#Test 3 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf43=c()
resultd43=c()

for(i in 1:150)
{
  y[181,]=as.matrix(data_Test3[i,])-mTest3+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf43[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd43[i]=(181 %in% temp2$outlier)
}

#Test 4 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf44=c()
resultd44=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test4[i,])-mTest4+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf44[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd44[i]=(181 %in% temp2$outlier)
}

#Test 5 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf45=c()
resultd45=c()

for(i in 1:150)
{
  y[181,]=as.matrix(data_Test5[i,])-mTest5+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf45[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd45[i]=(181 %in% temp2$outlier)
}

#Test 6 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:150,]=as.matrix(data_train4)-rep(1,150)%*%t(mtrain4)+matrix(0.0001*rnorm(150*2048),nrow = 150,ncol = 2048)

resultf46=c()
resultd46=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test6[i,])-mTest6+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf46[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd46[i]=(181 %in% temp2$outlier)
}

#Test 7 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf47=c()
resultd47=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test7[i,])-mTest7+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf47[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd47[i]=(181 %in% temp2$outlier)
}

#Test 8 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf48=c()
resultd48=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test8[i,])-mTest8+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf48[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd48[i]=(181 %in% temp2$outlier)
}

#Test 9 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf49=c()
resultd49=c()

for(i in 1:120)
{
  y[181,]=as.matrix(data_Test9[i,])-mTest9+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf49[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd49[i]=(181 %in% temp2$outlier)
}

#Test 10 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf410=c()
resultd410=c()


for(i in 1:150)
{
  y[181,]=as.matrix(data_Test1[i,])-mTest10+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf410[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd410[i]=(181 %in% temp2$outlier)

}

#Test 11 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf411=c()
resultd411=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test11[i,])-mTest11+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf411[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd411[i]=(181 %in% temp2$outlier)
}


#Test 12 to Train 1 CNN

y=matrix(0,nrow = 181,ncol = 2048)

y[1:180,]=as.matrix(data_train4)-rep(1,180)%*%t(mtrain4)+matrix(0.0001*rnorm(180*2048),nrow = 180,ncol = 2048)

resultf412=c()
resultd412=c()

for(i in 1:180)
{
  y[181,]=as.matrix(data_Test1[i,])-mTest12+0.0001*rnorm(2048,0,1)
  temp1=fbplot(t(y),factor = 3)
  resultf412[i]=(181 %in% temp1$outpoint)
  temp2=TVDMSS(t(y),nCurve = 181,nPoint = 2048)
  resultd412[i]=(181 %in% temp2$outlier)
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

fpr4 <- tpr4 <- 0;
for (i in 1:12){
  fpr4[i] <- sum(get(paste0("resultd4",i))[groundTruth[[i]]] == FALSE) /
    length(groundTruth[[i]])
  if (length(groundTruth[[i]]) == 
      length(get(paste0("resultd4",i)))){
    tpr4[i] <- 1
  }
  else{
    tpr4[i] <- sum(get(paste0("resultd4",i))[-groundTruth[[i]]] == FALSE) /
      (length(get(paste0("resultd4",i))) - length(groundTruth[[i]]))
  }
}
