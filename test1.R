var1_100_depth=c()

var1_200_depth=c()

varmixdepth=c()

for(i in 1:1000)
{
  num_processes <- 100
  num_observations <- 100
  
  # Set the AR(1) coefficient
  phi1 <- 0.8
  
  # Set the standard deviation of the noise term
  sigma <- 1
  
  # Generate the AR(1) processes using replicate
  ar1_100_processes <- replicate(num_processes, arima.sim(n = num_observations, list(ar = phi1), sd = sigma), simplify = FALSE)
  xar1_100=matrix(unlist(ar1_100_processes),100,100)
  
  # Generate the AR(1) processes using replicate
  ar1_200_processes <- replicate(num_processes, arima.sim(n = num_observations, list(ar = phi1), sd = sigma), simplify = FALSE)
  xar1_200=rbind(matrix(unlist(ar1_100_processes),100,100),matrix(unlist(ar1_200_processes),100,100))
  
  # Set the number of AR(1) and AR(2) processes and the length of each process
  num_ar2_processes <- 100
  num_observations <- 100
  
  # Set the AR(1) coefficient
  phi1_ar1 <- 0.8
  
  # Set the AR(2) coefficients
  phi1_ar2 <- 0.1
  phi2_ar2 <- -0.1
  
  # Set the standard deviation of the noise term
  sigma <- 1
  
  # Generate the AR(2) processes using replicate
  ar2_processes <- replicate(num_ar2_processes, arima.sim(n = num_observations, list(ar = c(phi1_ar2, phi2_ar2)), sd = sigma), simplify = FALSE)
  
  xarmix=rbind(matrix(unlist(ar1_100_processes),100,100),matrix(unlist(ar2_processes),100,100))
  
  library(fda)
  
  res_ar1=fbplot(t(xar1_100), factor = 3, plot = FALSE)
  res_ar2=fbplot(t(xar1_200), factor = 3, plot = FALSE)
  res_armix=fbplot(t(xarmix), factor = 3, plot = FALSE)
  
  depth_ar1=res_ar1$depth
  depth_ar2=res_ar2$depth
  depth_armix=res_armix$depth
  
  var1_100_depth[i]=var(depth_ar1)
  
  var1_200_depth[i]=var(depth_ar2)

  varmixdepth[i]=var(depth_armix)
  
}

vT=detectOutlier(t(xar1_100), nCurve = 100, nPoint = 100, 3)$TVD
mean(vT)
var(vT)

vT1=c()
for(i in 1:100)
{
  resv=detectOutlier(t(xar1_200[1:(100+i),]), nCurve = (100+i), nPoint = 100, 3)$TVD
  vT1[i]=var(resv)
}
plot(x=c(1:length(vT1)),y=vT1,type = "l")

vT2=c()
for(i in 1:100)
{
  resv=detectOutlier(t(xarmix[1:(100+i),]), nCurve = (100+i), nPoint = 100, 3)$TVD
  vT2[i]=var(resv)
}

plot(x=c(1:length(vT2)),y=vT2,type = "l")

hist(var1_100_depth)
hist(var1_200_depth)
hist(varmixdepth)



