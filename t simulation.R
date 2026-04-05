library(glmnet)
library(Matrix)
library(MASS)
library(quantreg)
library(lattice)
library(RSSampling)
library(foreach)
library(doParallel)

fun_theta=function(x,lamb,yet)
{
  theta=rep(0,length(x))
  for (i in 1:length(x))
  {
    if (abs(x[i])<lamb)
      theta[i]=0
    if (abs(x[i])>=lamb)
      theta[i]=x[i]/(1+yet)
  }
  return(theta)
}


# coefficient<-function(x,y)
# { 
# fit1=cv.glmnet(x,y,nfolds=5)
# c0=coef(fit1,s="lambda.min")
# b=matrix(as.vector(c0),length(c0),1)
# return (b)
# }
coef_LADLasso<-function(x,y,Lamb)
{
  dime=dim(x); p=dime[2]; n=dime[1];
  c0=matrix(rep(0,(p+1)*length(Lamb)),ncol=length(Lamb))
  Score=c(rep(0,length(Lamb)))
  for (j in c(1:length(Lamb)))
  {
    #fit1=rq.fit.lasso(x, y, tau = 0.5, lambda =Lamb[j], beta =.9995, eps = 1e-04)
    fit1 <-rq(y ~ x, tau=0.5, method="lasso",lambda =Lamb[j],eps=1e-02)
    Score[j]=AIC(fit1,k=log(100))  # k=2 AIC;  k<=0 BIC
    
    D=deviance(fit1)+fit1$df*log(n)
    coeff=fit1$coefficients
    coeff[coeff<1e-08]=0
    c0[,j]=coeff
  }
  J=which.min(Score)
  b=matrix(as.vector(c0[,J]),length(c0[,J]),1)
  
  d=list('coef'=b,'BICscore'=Score,'Id'=J)
}



fun_main=function(x,y,lamb)
{
  beta0=coef_LADLasso(x,y,lamb)$coef
  beta0=matrix(beta0[-1],p,1)
  gamma0=y-x%*%beta0-beta0[1]
  k0=sum(x^2)+1
  g=0
  while(max(abs(gamma0-g))>0.0001)
  {
    g=gamma0
    x1=beta0+(1/k0)*t(x)%*%y-(1/k0)*t(x)%*%(x%*%beta0+gamma0)
    x2=(1-(1/k0))*gamma0+(1/k0)*y-(1/k0)*x%*%beta0
    ll=lamb/k0
    yet=0.1
    beta0=fun_theta(x1,ll,yet)
    gamma0=fun_theta(x2,ll,yet)
  }
  gamma_final=gamma0
  beta_final=coef_LADLasso(x,y-gamma_final,lamb)$coef
  list(gamma_final=gamma_final,beta_final=beta_final)
}
######################
fun_HIM<-function(X,Y,alpha,n_out)
{
  n=dim(X)[1]; p=dim(X)[2]; pv=rep(0,n)
  Rhat=fun_rhat(X,Y)
  for (i in 1:n)        #    for (i in 1:n)
  {    
    Xi=X[-i,];  
    Yi=Y[-i];
    rhat=fun_rhat(Xi,Yi) 
    D0=(n^2)*(sum((rhat-Rhat)^2)/p)	                                
    pv[i]=1-pchisq(D0,1)         # the p-value
  }	
  ################# 
  Spv=sort.int(pv,index.return=TRUE)  # sorted p value
  Si=Spv$ix;
  dp=Spv$x-alpha*c(1:n)/n
  In=which(dp<=0)    # BH procedure to control the error rate
  if (length(In)>0)
  { 
    #rin=min(max(In),n/2);# the index of observations detected as influential observation( which is assumed less than n/2)
    rin=max(In)
    In_de_inf=Si[1:rin]  # the indices of observations  identified as influential ones. 
    Pow=length(which(In_de_inf<=n_out))/n_out 
    Size=length(which(In_de_inf>n_out))/(n-n_out) 
  }else{
    Pow=0
    Size=0
    In_de_inf=NULL
  }
  list(Pow=Pow,Size=Size,Id=In_de_inf)   # return the reduced data where influential observation has been removed.
}
#############################################################################

fun_rhat=function(X,Y)
{ 
  n=dim(X)[1]      
  rob_sd=apply(X,2,mad)
  X=X-rep(1,n)%o%apply(X,2,median);   
  X=X%*%diag(1/rob_sd);                 
  Y=(Y-median(Y))/mad(Y)   
  Y=matrix(Y,ncol=1)
  rhat=t(Y)%*%X/n
  return(rhat)
}
#####################################################################################################################
##Mip
fun_mippv=function(X,Y,n,p,n_subset,subset_vol,clean_setv)
{
  rob_sd=apply(X,2,mad)
  X=X-rep(1,n)%o%apply(X,2,median);   
  X=X%*%diag(1/rob_sd);
  Y=(Y-median(Y))/mad(Y)
  
  TT=rep(0,n_subset)
  Tmax=rep(0,length(clean_setv))
  Tmin=rep(0,length(clean_setv))
  for (i in 1:length(clean_setv))
  {
    S_i=setdiff(clean_setv,clean_setv[i])     
    
    for (m in 1: n_subset)
    { 
      I=sample(S_i,size =subset_vol,replace=FALSE,prob=NULL)
      X1=X[c(clean_setv[i],I),]  
      Y1=Y[,c(clean_setv[i],I)] 
      X2=X[I,]  
      Y2=Y[,I] 
      rhat1= Y1%*%X1/(subset_vol+1)
      rhat2=Y2%*%X2/subset_vol     
      TT[m]=((subset_vol+1)^2)*(sum((rhat1-rhat2)^2)/p)
    }
    Tmax[i]=max(TT) 
    Tmin[i]=min(TT)
  }
  
  list(Tmax=Tmax,Tmin=Tmin)
}




fun_mipmasking=function(X,Y,n,p,n_subset,subset_vol,clean_setv,alpha)
{
  Tmax=(fun_mippv(X,Y,n,p,n_subset,subset_vol,clean_setv))$Tmax
  pv=1-pchisq(Tmax,1)
  Spv=sort.int(pv,index.return=TRUE)  # sorted p value
  Si=Spv$ix
  dp=Spv$x-alpha*c(1:length(Tmax))/length(Tmax)
  
  In=which(dp<=0)    # BH procedure to control the error rate 
  if (length(In)==0)
  {clean_set=clean_setv}
  else
  {
    rin=max(In)  
    inf_set=clean_setv[Si[1:rin]] 
    clean_set=setdiff(clean_setv,inf_set)    
  }
  
  list(clean_set=clean_set)
}







fun_mipswamping=function(X,Y,n,p,n_subset,subset_vol,clean_setv,ep=0.05,alpha)
{  
  Tmin=(fun_mippv(X,Y,n,p,n_subset,subset_vol,clean_setv))$Tmin
  pvv=1-pchisq(Tmin,1)
  Spvv=sort.int(pvv,index.return=TRUE) 
  Sii=Spvv$ix
  dpv=Spvv$x-alpha*c(1:length(Tmin))/length(Tmin)
  
  In=which(dpv<=0)    
  if (length(In)==0)
  {clean_set=clean_setv}
  else
  {
    rin=max(In)  
    inf_setv=clean_setv[Sii[1:min(floor(ep*n),rin)]]
    clean_set=setdiff(clean_setv,inf_setv)
  }
  
  clean_setv=clean_set
  list(clean_setv=clean_setv)
}



fun_mipchecking=function(X,Y,n,p,inf_t,clean_t,alpha)   
{    
  rob_sd=apply(X,2,mad)
  X=X-rep(1,n)%o%apply(X,2,median);   
  X=X%*%diag(1/rob_sd);
  Y=(Y-median(Y))/mad(Y) 
  T=rep(0,length(inf_t))
  for (i in 1:length(inf_t))   
  {        
    X1=X[c(inf_t[i],clean_t),]  
    Y1=Y[,c(inf_t[i],clean_t)] 
    X2=X[clean_t,]  
    Y2=Y[,clean_t] 
    rhat1=Y1%*%X1/(length(clean_t)+1)
    rhat2=Y2%*%X2/length(clean_t)
    T[i]=((length(clean_t)+1)^2)*(sum((rhat1-rhat2)^2)/p)     
  }
  pv_inf=1-pchisq(T,1)    
  Spv_inf=sort.int(pv_inf,index.return=TRUE)  
  Si=Spv_inf$ix
  dp=Spv_inf$x-alpha*c(1:length(inf_t))/length(inf_t)
  
  In=which(dp<=0)   
  if (length(In)==0)
  {clean_setfinal=c(1:n)
  inf_setfinal=setdiff(c(1:n),clean_setfinal)
  }
  
  else{ 
    rin=max(In)  
    inf_setfinal=inf_t[Si[1:rin]] 
    clean_setfinal=setdiff(c(1:n),inf_setfinal)
  }
  
  list(inf_setfinal=inf_setfinal)   
}







MIP=function(X,Y,n,p,n_subset,subset_vol,ep=0.05,alpha)
{
  clean_set=c(1:n) 
  clean_setv=fun_mipswamping(X,Y,n,p,n_subset,subset_vol,clean_set,ep,alpha)$clean_setv
  clean_set=fun_mipmasking(X,Y,n,p,n_subset,subset_vol,clean_setv,alpha)$clean_set
  while (length(clean_set)<n/2)
  {
    subset_vol=floor(length(clean_setv)/2)
    clean_setv=fun_mipswamping(X,Y,n,p,q,n_subset,subset_vol,clean_setv,ep,alpha)$clean_setv
    subset_vol=floor(length(clean_setv)/2)
    clean_set=fun_mipmasking(X,Y,n,p,q,n_subset,subset_vol,clean_setv,alpha)$clean_set
  }
  clean_t=clean_set  
  inf_t=setdiff(c(1:n),clean_t)
  inf_setfinal=fun_mipchecking(X,Y,n,p,inf_t,clean_t,alpha)$inf_setfinal
  list(inf_setfinal=inf_setfinal)
  
  
}




##new method

lfn=function(x,y)
{
  n=length(y)
  m=length(x)
  Fy=ecdf(y)
  fx=Fy(x)
  lx=c()
  for(i in 1:m)
  {
    if(fx[i]==0)  #avoid infty problem
    {
      lx[i]=-2*log(n)
    } 
    else if(fx[i]==1)
    {
      lx[i]=2*log(n)
    } 
    else 
    {
      lx[i]=log(fx[i]/(1-fx[i]))
    }
  }
  return(lx)
}


fun_newsubset=function(X,Y,n,p,n_subset,subset_vol,clean_setv)
{
  rob_sd=apply(X,2,mad)
  X=X-rep(1,n)%o%apply(X,2,median);   
  X=X%*%diag(1/rob_sd);
  Y=(Y-median(Y))/mad(Y)
  
  TT=rep(0,n_subset)
  Tmax=rep(0,length(clean_setv))
  Tmin=rep(0,length(clean_setv))
  for (i in 1:length(clean_setv))
  {
    S_i=setdiff(clean_setv,clean_setv[i])     
    for (m in 1: n_subset)
    { 
      I1=sample(S_i,size =floor(n/2),replace=FALSE,prob=NULL) #sample
      a=Rrss(Y[I1],m=floor(length(I1)/10),r=10,type="l",sets=FALSE,alpha=0.1)
      S_i1=setdiff(S_i,I1)
      I2=sample(S_i1,size =subset_vol,replace=FALSE,prob=NULL)
      s1=I2 #1:2n/(I,k), n-1 samples
      s2=c(I2,i) #1:2n/I, n samples
      X1=X[s1,]  
      Y1=Y[s1] 
      X2=X[s2,]  
      Y2=Y[s2] 
      LY1=lfn(Y1,a) #transform
      LY2=lfn(Y2,a)
      frhat1= LY1%*%X1/subset_vol
      frhat2=LY2%*%X2/(subset_vol+1) 
      TT[m]=((subset_vol+1)^2)*(sum((frhat1-frhat2)^2)/p) #compute dk
    }
    Tmax[i]=max(TT) 
    Tmin[i]=min(TT)
  }
  list(Tmax=Tmax,Tmin=Tmin)
}

#max

fun_max=function(X,Y,n,p,n_subset,subset_vol,clean_setv,alpha)
{
  
  Tmax=(fun_newsubset(X,Y,n,p,n_subset,subset_vol,clean_setv))$Tmax
  pv_max=2*exp(-sqrt(Tmax))/(1+exp(-sqrt(Tmax)))
  Spv_max=sort.int(pv_max,index.return=TRUE)  # sorted p value
  Si_max=Spv_max$ix
  dp_max=Spv_max$x-alpha*c(1:length(Tmax))/length(Tmax)
  
  In_max=which(dp_max<=0)    # BH procedure to control the error rate 
  if (length(In_max)==0)
  {clean_set_max=clean_setv}
  else
  {
    rin_max=max(In_max)  
    inf_set_max=clean_setv[Si_max[1:rin_max]] 
    clean_set_max=setdiff(clean_setv,inf_set_max)    
  }
  
  list(clean_set_max=clean_set_max)
}



#min

fun_min=function(X,Y,n,p,n_subset,subset_vol,clean_setv,ep=0.05,alpha)
{  
  Tmin=(fun_newsubset(X,Y,n,p,n_subset,subset_vol,clean_setv))$Tmin
  pv_min=2*exp(-sqrt(Tmin))/(1+exp(-sqrt(Tmin)))
  Spv_min=sort.int(pv_min,index.return=TRUE)  # sorted p value
  Si_min=Spv_min$ix
  dp_min=Spv_min$x-alpha*c(1:length(Tmin))/length(Tmin)
  
  In_min=which(dp_min<=0)    
  if (length(In_min)==0)
  {clean_set_min=clean_setv}
  else
  {
    rin_min=max(In_min)  
    inf_set_min=clean_setv[Si_min[1:min(floor(ep*n),rin_min)]]
    clean_set_min=setdiff(clean_setv,inf_set_min)
  }  
  
  list(clean_set_min=clean_set_min)
}

#check

fun_newchecking=function(X,Y,n,p,inf_t,clean_t,alpha)   
{    
  rob_sd=apply(X,2,mad)
  X=X-rep(1,n)%o%apply(X,2,median);   
  X=X%*%diag(1/rob_sd);
  Y=(Y-median(Y))/mad(Y)
  
  T=rep(0,length(inf_t))
  for (i in 1:length(inf_t))   
  {       
    n1=floor(length(clean_t)/2)
    I1=sample(clean_t,size =n1,replace=FALSE,prob=NULL)
    I2=setdiff(clean_t,I1)
    a=Rrss(Y[I2],m=floor(length(I1)/10),r=10,type="l",sets=FALSE,alpha=0.1)
    X1=X[c(inf_t[i],I1),]  
    Y1=Y[,c(inf_t[i],I1)] 
    X2=X[I1,]  
    Y2=Y[,I1] 
    LY1=lfn(Y1,a) #transform
    LY2=lfn(Y2,a)
    frhat1=LY1%*%X1/(length(I1)+1)
    frhat2=LY2%*%X2/length(I1)
    T[i]=((length(I1)+1)^2)*(sum((frhat1-frhat2)^2)/p)     
  }
  pv_inf=2*exp(-sqrt(T))/(1+exp(-sqrt(T)))
  Spv_inf=sort.int(pv_inf,index.return=TRUE)  
  Si=Spv_inf$ix
  dp=Spv_inf$x-alpha*c(1:length(inf_t))/length(inf_t)
  
  In=which(dp<=0)   
  if (length(In)==0)
  {clean_setfinal=c(1:n)
  inf_setfinal=setdiff(c(1:n),clean_setfinal)
  }
  
  else{ 
    rin=max(In)  
    inf_setfinal=inf_t[Si[1:rin]] 
    clean_setfinal=setdiff(c(1:n),inf_setfinal)
  }
  
  list(inf_setfinal=inf_setfinal)   
}

newmethod=function(X,Y,n,p,n_subset,subset_vol,ep=0.05,alpha)
{
  clean_set=c(1:n) 
  clean_set_min=fun_min(X,Y,n,p,n_subset,subset_vol,clean_set,ep,alpha)$clean_set_min
  clean_set_max=fun_max(X,Y,n,p,n_subset,subset_vol,clean_set_min,alpha)$clean_set_max
  flag=0
  while (length(clean_set_max)<n/2)
  {
    subset_vol=floor(length(clean_set_min)/4)
    clean_set_min=fun_min(X,Y,n,p,n_subset,subset_vol,clean_set_min,ep,alpha)$clean_set_min
    subset_vol=floor(length(clean_set_min)/4)
    clean_set_max=fun_max(X,Y,n,p,q,n_subset,subset_vol,clean_set_min,alpha)$clean_set_max
  }
  clean_t=clean_set_max  
  inf_t=setdiff(c(1:n),clean_t)
  inf_setfinal=fun_newchecking(X,Y,n,p,inf_t,clean_t,alpha)$inf_setfinal
  list(inf_setfinal=inf_setfinal)
  
}




#generate data
DATAF<-function(n,p,n_out,mx_shift,my_shift,A,model)
{  
  
  
  if (model==1) 
  {
    X1=mvrnorm(n,mu=rep(0,p),Sigma = A)
    beta=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5)),p,1);
    Y1=X1%*%beta+0.5*rnorm(n,0,0.1); 
    
    X2=mvrnorm(n_out,mu=rep(0,p),Sigma = A)
    X2=X2+0.5*mx_shift*c(rep(0,p-0.1*p),rep(1,0.1*p))
    Y2=rep(0,n_out)
    b=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5-20),seq(0,mx_shift/10,length.out=20)),p,1)
    Y2=X2%*%b+my_shift+rnorm(n_out,0,0.5)
    Y2=sign(rnorm(n_out,0,1))*Y2
  }
  
  
  if (model==2) 
  {
    X1=mvrnorm(n,mu=rep(0,p),Sigma = A)
    beta=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5)),p,1);
    Y1=X1%*%beta+0.5*rt(n,1); 
    
    X2=mvrnorm(n_out,mu=rep(0,p),Sigma = A)
    X2=X2+0.5*mx_shift*c(rep(0,p-0.1*p),rep(1,0.1*p))
    Y2=rep(0,n_out)
    b=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5-20),seq(0,mx_shift/10,length.out=20)),p,1)
    Y2=X2%*%b+2*my_shift+rnorm(n_out,0,0.5)
    Y2=sign(rnorm(n_out,0,1))*Y2
  }
  
  
  #if (model==2) 
  #{
    #X1=mvrnorm(n,mu=rep(0,p),Sigma = A)
    #beta=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5)),p,1);
    #Y1=X1%*%beta+0.5*rnorm(n,0,0.1); 
     
    #X2=mvrnorm(n_out,mu=rep(0,p),Sigma = A)
    #X2=X2+0.5*mx_shift*c(rep(0,p-0.1*p),rep(1,0.1*p))
    #Y2=rep(0,n_out)
    #b=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5-20),seq(0,mx_shift/10,length.out=20)),p,1)
    #Y2=X2%*%b+rnorm(1,0,0.5)
    #Y2=sign(rnorm(n_out,0,1))*Y2
  #}
  
  if (model==3) 
  {
    X1=mvrnorm(n,mu=rep(0,p),Sigma = A)
    X1=matrix(X1,n,p)
    beta=beta=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5)),p,1);
    Y1=X1%*%beta+0.5*rt(n,1); 
    # 
    X2=mvrnorm(n_out,mu=rep(0,p),Sigma = A)
    #X2=X2+0.5*mx_shift*c(rep(0,p-0.1*p),rep(1,0.1*p))
    Y2=rep(0,n_out)
    b=beta
      #matrix(c(seq(0,0.5,length.out=floor(0.5*p)),rep(0,floor(0.5*p)-20),seq(0,mx_shift/10,length.out=20)),p,1)
    Y2=X2%*%b+my_shift+rnorm(1,0,0.5)
    Y2=sign(rnorm(n_out,0,1))*Y2
  }
  
  if (model==4) 
  {
    X1=mvrnorm(n,mu=rep(0,p),Sigma = A)
    X1=matrix(X1,n,p)
    beta=beta=matrix(c(0.2,0.4,0.5,0.3,0.2,rep(0,p-5)),p,1);
    Y1=X1%*%beta+rnorm(n,5,1)*(2*rbinom(n,1,0.5)-1)
    # 
    X2=mvrnorm(n_out,mu=rep(0,p),Sigma = A)
    #X2=X2+0.5*mx_shift*c(rep(0,p-0.1*p),rep(1,0.1*p))
    Y2=rep(0,n_out)
    b=beta
    #matrix(c(seq(0,0.5,length.out=floor(0.5*p)),rep(0,floor(0.5*p)-20),seq(0,mx_shift/10,length.out=20)),p,1)
    Y2=X2%*%b+my_shift+rnorm(1,0,0.5)
    Y2=sign(rnorm(n_out,0,1))*Y2
  }
  
  
  if (n_out>0)                            # n_out is the number of influential observations 
  {
    X=rbind(X2[1:n_out,],X1[(n_out+1):n,])  # combination of influential and non-influential observations. 
    Y1[1:n_out]=Y2[1:n_out];
    Y=Y1; 
  } else {
    X=X1;  Y=Y1
  }
  
  list(X=X,Y=Y,b0=beta)   # X0,Y0 is the unstandardized data(used for lasso fitting); X,Y is the standardized data;  beta is the true parameter 

}






fun_simulation=function(nsim)
{
  n=200
  p=1000
  n_out=floor(n*0.05)
  corf=0.5
  A=diag(rep(1,p))
  for (i in 1:p)
  { for (j in i:p)
  {
    A[i,j]=corf^(abs(j-i))
    A[j,i]=A[i,j]
  }
  }
  
  
  subset_vol=floor(0.25*n)
  n_subset_opt=100
  alpha=0.05
  ep=0.05
  #model 1,2, 1, t1, 2 norm
  model=4 #1,2,3,4
  
  #step 
  Mx_shift=seq(0,4,by=2) 
  Pow_new=Size_new=Pow_MIP=Size_MIP=Pow_HIM=Pow_she=Size_she=Size_HIM=timeused_she=timeused_HIM=timeused_MIP=timeused_new=rep(0,length(Mx_shift)+1)
  
  for (w in 1:(length(Mx_shift)+1))
  {
    if(w==1)
    {
      mx_shift=0
      my_shift=0
    } else {
      
      mx_shift=Mx_shift[w-1]+2
      my_shift=mx_shift+7
    }
    
    
    
    Data=DATAF(n,p,n_out,mx_shift,my_shift,A,model);
    X=matrix(unlist(Data$X),ncol=p)   
    Y=matrix(unlist(Data$Y),nrow=1)
    beta=matrix(unlist(Data$b0),1,p)
    rob_sd=apply(X,2,mad)
    X=X-rep(1,n)%o%apply(X,2,median);   
    X=X%*%diag(1/rob_sd);
    Y=(Y-median(Y))/mad(Y)
    
    
    #################################MIP
    subset_vol=floor(0.5*n)
    starttime1=Sys.time()
    Id_MIP=MIP(X,Y,n,p,n_subset_opt,subset_vol,ep=0.05,alpha)$inf_setfinal
    endtime1=Sys.time()
    timeused_MIP[w]=endtime1-starttime1
    Pow_MIP[w]=(length(which(Id_MIP<=n_out)))/n_out
    Size_MIP[w]=(length(which(Id_MIP>n_out)))/(n-n_out)
    
    #############################HIM
    starttime2=Sys.time()
    Id_HIM=fun_HIM(X,Y,alpha,n_out)$Id
    endtime2=Sys.time()
    timeused_HIM[w]=endtime2-starttime2
    Pow_HIM[w]=(length(which(Id_HIM<=n_out)))/n_out
    Size_HIM[w]=(length(which(Id_HIM>n_out)))/(n-n_out)
    
    #####################################NEW
    subset_vol=floor(0.25*n)
    starttime3=Sys.time()
    Id_new=newmethod(X,Y,n,p,n_subset_opt,subset_vol,ep=0.05,alpha)$inf_setfinal
    endtime3=Sys.time()
    timeused_new[w]=endtime3-starttime3
    Pow_new[w]=(length(which(Id_new<=n_out)))/n_out
    Size_new[w]=(length(which(Id_new>n_out)))/(n-n_out)
    
    ####################SHE
    
    lambda_m=seq(0.01*p,0.1*p,by=0.01*p)
    rss_cv=rep(0,length(lambda_m))
    starttime4=Sys.time()
    for (i in 1:length(lambda_m))
    {
      lamb=lambda_m[i]
      
      bb=fun_main(X,t(Y),lamb)
      bbb=bb$gamma_final
      cc=bb$beta_final
      ccc=as.matrix(cc[-1])
      rss_cv[i]=log(sum(t(Y)-as.matrix(bbb)-X%*%ccc)^2)+1/n*(7*(length(which(bbb!=0))+1)*n+2*length(which(bbb!=0))*log(0.57721566*n/length(which(bbb!=0))))
    }
    id.min=which.min(rss_cv)
    lambda_op=lambda_m[id.min]
    #lambda_op=0.1*p
    b_final=fun_main(X,t(Y),lambda_op)$gamma_final
    Id_she=which(b_final!=0)
    endtime4=Sys.time()
    timeused_she[w]=endtime4-starttime4
    Pow_she[w]=(length(which(Id_she<=n_out)))/n_out
    Size_she[w]=(length(which(Id_she>n_out)))/(n-n_out) 
    
    
    if (mx_shift==0)
    {
      Pow_MIP[w]=0
      Size_MIP[w]=length(Id_MIP)/n
      Pow_new[w]=0
      Size_new[w]=length(Id_new)/n
      Pow_HIM[w]=0
      Size_HIM[w]=length(Id_HIM)/n 
      Pow_she[w]=0
      Size_she[w]=length(Id_she)/n 
    }
    
    
    
  }
  
  #Pow_HIM,Size_HIM
  result=cbind(Pow_HIM,Size_HIM,Pow_MIP,Size_MIP,Pow_new,Size_new,Pow_she, Size_she,timeused_HIM,timeused_MIP,timeused_new,timeused_she)
  list(result=result)
  ###
}
library(glmnet)
library(Matrix)
library(MASS)
library(quantreg)
library(lattice)
library(RSSampling)
loop=1   #### simulation number
nsim=10
p=1000
set.seed(1000)
cl <- makeCluster(96)
registerDoParallel(cl)
Test = foreach(nsim = 1:loop,.packages = c("MASS","Matrix","glmnet","quantreg","lattice","RSSampling")) %dopar% fun_simulation(nsim) 
stopImplicitCluster()
stopCluster(cl)

Result= lapply(1:loop,function(x) {Test[[x]]$result})
Result_mean= Reduce("+",Result)/loop
print(Result_mean)




setwd('F:/')
write.csv(Result_mean, file="Result_mean.csv")

rm(Test)
gc()
