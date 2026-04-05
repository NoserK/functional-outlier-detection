cnnresult=output$V1
cnntpr=c()
cnnfpr=c()
for(i in 1:16)
{
  cnntpr=c(cnntpr,cnnresult[(24*(i-1)+1):(24*(i-1)+12)])
  cnnfpr=c(cnnfpr,cnnresult[(24*(i-1)+13):(24*(i-1)+24)])
}

plot(x=cnnfpr,y=cnntpr,xlim=c(0,1),ylim=c(0,1))

cnntf <- data.frame(TPR = cnntpr, FPR = cnnfpr)
cnntf <- subset(cnntf, FPR != 0)

plot(cnntf$FPR,cnntf$TPR,xlim=c(0,1),ylim=c(0,1))

cnnresult1=output1$V1[386:769]
cnntpr1=c()
cnnfpr1=c()
for(i in 1:16)
{
  cnntpr1=c(cnntpr1,cnnresult1[(24*(i-1)+1):(24*(i-1)+12)])
  cnnfpr1=c(cnnfpr1,cnnresult1[(24*(i-1)+13):(24*(i-1)+24)])
}

plot(x=cnnfpr1,y=cnntpr1,xlim=c(0,1),ylim=c(0,1))

cnntf1 <- data.frame(TPR = cnntpr1, FPR = cnnfpr1)
cnntf1 <- subset(cnntf1, FPR != 0)

plot(cnntf1$FPR,cnntf1$TPR,xlim=c(0,1),ylim=c(0,1))