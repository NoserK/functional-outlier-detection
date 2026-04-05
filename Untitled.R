library(raster)

#train 1

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Train/Train001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train001 <- stack(tif_files)

plot(train001)

x=matrix(0,nrow = 158,ncol = 201)

for(i in 1:200)
{
  temp=as.matrix(train001[[i]])
  feature=temp%*%t(temp)
  result=eigen(feature)$value
  x[,i]=result
}

#test 1

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test001 <- stack(tif_files)


y=matrix(0,nrow = 158,ncol = 200)
ot1=rep(0,200)

for(i in 1:200)
{
  temp=as.matrix(test001[[i]])
  feature=temp%*%t(temp)
  result=eigen(feature)$value
  x[,201]=result
  y[,i]=result
  result1=detectOutlier(x,201,158,1.5)
  temp1=as.numeric(result1$outlier)
  if(max(temp1)==201)
  {
    ot1[i]=1
  }
}

trueot1=rep(0,200)
trueot1[60:152]=1
tp=sum(ot1*trueot1)
fp=sum(ot1[which(trueot1==0)])
tp
fp








#train 2

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Train/Train002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train002 <- stack(tif_files)

plot(train002)

x=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x[,i]=as.vector(train002[[i]])
}

result2=detectOutlier(x,200,158*238,30)

fp2=length(as.numeric(result2$outlier))
fp2

#train 3

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Train/Train003/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train003 <- stack(tif_files)

plot(train003)

x=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x[,i]=as.vector(train003[[i]])
}

result3=detectOutlier(x,200,158*238,30)

fp3=length(as.numeric(result3$outlier))
fp3

#train 4

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Train/Train004/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train004 <- stack(tif_files)

plot(train004)

x=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x[,i]=as.vector(train004[[i]])
}

result4=detectOutlier(x,200,158*238,30)

fp4=length(as.numeric(result4$outlier))
fp4


#train 5

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Train/Train005/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
train005 <- stack(tif_files)

plot(train005)

x=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x[,i]=as.vector(train005[[i]])
}

result5=detectOutlier(x,200,158*238,1.5)

fp5=length(as.numeric(result5$outlier))
fp5

#test 1

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test001/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test001 <- stack(tif_files)

plot(test001)

x=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  plot(test001[[i]])
  x[,i]=as.vector(test001[[i]])
}


resultt1=detectOutlier(x,200,158*238,3)

ot1=as.numeric(resultt1$outlier)

tpt1=ot1[which(ot1>=60&ot1<=152)]
fpt1=ot1[which(ot1<60|ot1>152)]

#test 2

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test002/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test002 <- stack(tif_files)

x2=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  plot(test002[[i]])
  x2[,i]=as.vector(test002[[i]])
}


resultt2=detectOutlier(x2,200,158*238,3)

ot2=as.numeric(resultt2$outlier)

tpt2=ot2[which(ot2>=50&ot2<=175)]
fpt2=ot2[which(ot2<50|ot2>175)]

#test 3

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test003/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test003 <- stack(tif_files)

x3=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  plot(test003[[i]])
  x3[,i]=as.vector(test003[[i]])
}


resultt3=detectOutlier(x3,200,158*238,3)

ot3=as.numeric(resultt3$outlier)

tpt3=ot3[which(ot3>=91)]
fpt3=ot3[which(ot3<91)]

#test 4

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test004/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test004 <- stack(tif_files)

x4=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x4[,i]=as.vector(test004[[i]])
}


resultt4=detectOutlier(x4,200,158*238,3)

ot4=as.numeric(resultt4$outlier)

tpt4=ot4[which(ot4>=31&ot4<=168)]
fpt4=ot4[which(ot4<31|ot4>168)]

#test 5

# List all TIFF files in your directory
tif_files <- list.files(path = "Desktop/fod/UCSD_Anomaly_Dataset.v1p2/UCSDped1/Test/Test005/",pattern = "\\.tif$", full.names = TRUE)

# Read all TIFF files into a single raster stack
test005 <- stack(tif_files)

x5=matrix(0,nrow = 158*238,ncol = 200)

for(i in 1:200)
{
  x5[,i]=as.vector(test005[[i]])
}


resultt5=detectOutlier(x5,200,158*238,3)

ot5=as.numeric(resultt5$outlier)

tpt5=ot5[which((ot5>=5&ot5<=90)|(ot5>=110&ot5<=200))]
fpt5=ot5[which(ot5<5|(ot5>90&ot5<110))]

boxplot(result2$MSS)
boxplot(result3$MSS)
boxplot(result4$MSS)

boxplot(result2$TVD)
boxplot(result3$TVD)
boxplot(result4$TVD)

boxplot(result1$MSS)
boxplot(result1$TVD)

