msplot(y)
ranky=order(extremal_depth(y),decreasing = TRUE)
extreme_rank_length(y)
directional_quantile(y, quantiles = c(0.005, 0.995))
dir_out(y)
p=2048
grid <- seq(0, 1, length.out = p)
fD <- fData(grid, y)
outliergram(fD)

dirOutl(t(y[1:160,]))

# Set the AR(1) coefficient
phi1 <- 0.8

# Set the standard deviation of the noise term
sigma <- 1
ar1_process=replicate(160, arima.sim(n = 1024, list(ar = phi1), sd = sigma), simplify = FALSE)
y=matrix(unlist(ar1_process),nrow = 160,ncol = 1024)
y[160,]=y[160,]+0.5*c(1:1024)-256

res=dirOutl(t(y))