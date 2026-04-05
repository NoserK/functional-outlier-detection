cov.rob <- function(x, cor = FALSE, quantile.used = floor((n+p+1)/2),
                    method = c("mve", "mcd", "classical"), nsamp = "best", seed)
{
  method <- match.arg(method)
  x <- as.matrix(x)
  if(any(is.na(x)) || any(is.infinite(x)))
    stop("missing or infinite values are not allowed")
  n <- nrow(x); p <- ncol(x)
  if(n < p+1)
    stop(gettextf("at least %d cases are needed", p+1), domain = NA)
  if(method == "classical") {
    ans <- list(center = colMeans(x), cov = var(x))
  } else {
    if(quantile.used < p+1)
      stop(gettextf("'quantile' must be at least %d", p+1), domain = NA)
    if(quantile.used > n-1)
      stop(gettextf("'quantile' must be at most %d", n-1), domain = NA)
    ## re-scale to roughly common scale
    divisor <- apply(x, 2, IQR)
    if(any(divisor == 0)) stop("at least one column has IQR 0")
    x <- x /rep(divisor, rep(n,p))
    qn <- quantile.used
    ps <- p + 1
    nexact <- choose(n, ps)
    if(is.character(nsamp) && nsamp == "best")
      nsamp <- if(nexact < 5000) "exact" else "sample"
    if(is.numeric(nsamp) && nsamp > nexact) {
      warning(sprintf(ngettext(nexact,
                               "only %d set, so all sets will be tried",
                               "only %d sets, so all sets will be tried"),
                      nexact), domain = NA)
      nsamp <- "exact"
    }
    samp <- nsamp != "exact"
    if(samp) {
      if(nsamp == "sample") nsamp <- min(500*ps, 3000)
    } else nsamp <- nexact
    if (nsamp > 2147483647) {
      if(samp)
        stop(sprintf("Too many samples (%.3g)", nsamp))
      else
        stop(sprintf('Too many combinations (%.3g) for nsamp = "exact"', nsamp))
    }
    if(samp && !missing(seed)) {
      if(exists(".Random.seed", envir=.GlobalEnv, inherits=FALSE))  {
        seed.keep <- get(".Random.seed", envir=.GlobalEnv, inherits=FALSE)
        on.exit(assign(".Random.seed", seed.keep, envir=.GlobalEnv))
      }
      assign(".Random.seed", seed, envir=.GlobalEnv)
    }
    z <-  .C(mve_fitlots,
             as.double(x), as.integer(n), as.integer(p),
             as.integer(qn), as.integer(method=="mcd"),
             as.integer(samp), as.integer(ps), as.integer(nsamp),
             crit=double(1), sing=integer(1L), bestone=integer(n))
    z$sing <- paste(z$sing, "singular samples of size", ps,
                    "out of", nsamp)
    crit <- z$crit + 2*sum(log(divisor)) +
      if(method=="mcd") - p * log(qn - 1) else 0
    best <- seq(n)[z$bestone != 0]
    if(!length(best)) stop("'x' is probably collinear")
    means <- colMeans(x[best, , drop = FALSE])
    rcov <- var(x[best, , drop = FALSE]) * (1 + 15/(n - p))^2
    dist <- mahalanobis(x, means, rcov)
    cut <- qchisq(0.975, p) * quantile(dist, qn/n)/qchisq(qn/n, p)
    cov <- divisor * var(x[dist < cut, , drop = FALSE]) *
      rep(divisor, rep(p, p))
    attr(cov, "names") <- NULL
    ans <- list(center =
                  colMeans(x[dist < cut, , drop = FALSE]) * divisor,
                cov = cov, msg = z$sing, crit = crit, best = best)
  }
  if(cor) {
    sd <- sqrt(diag(ans$cov))
    ans <- c(ans, list(cor = (ans$cov/sd)/rep(sd, rep(p, p))))
  }
  ans$n.obs <- n
  ans
}


dir_out <- function(dts, data_depth = "random_projections",
                    n_projections = 200L, seed = NULL,
                    return_distance = TRUE,
                    return_dir_matrix = FALSE){
  # library used: Mass::cov_rob,
  data_dim  <-  dim(dts)
  #data_depth <- match.arg(data_depth)
  if(is.data.frame(dts)){
    dts <- as.matrix(dts)
  }
  if(!is.array(dts))
    stop("Argument \"dts\" must be a dataframe, a matrix or 3-dimensional array.")
  
  if (any(!is.finite(dts)))
    stop("Missing or infinite values are not allowed in argument \"dts\".")
  
  if(data_dim[1] < 3){
    stop("n must be greater than 3.")
  }
  
  if (length(data_dim) == 2){ # univariate
    #############################################################3
    #median_vec <- apply(dt, 2, median)
    #mad_vec <- apply(dt, 2, mad)
    #dir_out_matrix <- sweep(sweep(dt, 2, median_vec), 2, mad_vec, FUN = "/")
    ################################################
    dts  <- t(dts)
    median_vec <- apply(dts, 1, median)
    mad_vec <- apply(dts, 1, mad)
    dir_out_matrix <- t((dts-median_vec)/(mad_vec)) # dir_out_matrix <- (dts-median_vec)/(mad_vec)
    mean_dir_out <- apply(dir_out_matrix, 1, mean, na.rm = T) # colMeans(dir_out_matrix, na.rm = T)
    var_dir_out <- apply(dir_out_matrix, 1, var, na.rm = T) # apply(dir_out_matrix, 2, var, na.rm = T)
    
    if(return_distance){
      ms_matrix <- (cbind(mean_dir_out, var_dir_out))
      mcd_obj  <- cov.rob(ms_matrix, method = "mcd", nsamp = "best")
      robust_cov <- mcd_obj$cov
      robust_mean <- (mcd_obj$center)
      distance <- unname(mahalanobis(ms_matrix, robust_mean, robust_cov))
    }
  } else if (length(data_dim) == 3) {# multivariate
    n <- data_dim[1]
    p <- data_dim[2]
    d <- data_dim[3]
    #dir_out_matrix2  <- array(0, dim = c(n, p, d))  # to cpp
    if(data_depth == "random_projections"){
      dir_out_matrix <- apply(dts, 2, function(x){
        outlyingness <- (1/projection_depth(x, n_projections = n_projections, seed = seed)) - 1
        median_vec  <-  x[order(outlyingness)[1], ] # dts[order(outlyingness)[1],j,]
        median_dev <- sweep(x, 2, median_vec )
        spatial_sign <- sqrt(rowSums((median_dev)^2))
        spatial_sign <- median_dev/spatial_sign
        spatial_sign[!is.finite(spatial_sign[,1]), ] <- 0 # check which row has an nan or infinite
        spatial_sign * outlyingness
      })
      #dir_out_matrix <- t(dir_out_matrix)
      #dim(dir_out_matrix) <- c(p, n, d)
      #dir_out_matrix <- aperm(dir_out_matrix, c(2, 1, 3))
      dir_out_matrix <- aperm(`dim<-`(t(dir_out_matrix), c(p, n, d)), c(2, 1, 3))
      
    } else {
      stop("depth method not supported.")
    }
    mean_dir_out  <- apply(dir_out_matrix, c(1,3), mean, na.rm = T)
    var_dir_out <- (apply(dir_out_matrix^2, 1, sum, na.rm = T)/p) - rowSums(mean_dir_out^2, na.rm = T)
    if (return_distance){
      ms_matrix <- (cbind(mean_dir_out, var_dir_out))
      mcd_obj  <- MASS::cov.rob(ms_matrix, method = "mcd", nsamp = "best")
      robust_cov <- mcd_obj$cov
      robust_mean <- (mcd_obj$center)
      distance <- mahalanobis(ms_matrix, robust_mean, robust_cov)
    }
  }
  else{
    stop("A 2-dimensional or 3-dimensional array is required.")
  }
  if (return_distance){
    if (return_dir_matrix){
      return(list(mean_outlyingness = unname(mean_dir_out),
                  var_outlyingness = unname(var_dir_out),
                  distance = distance,
                  ms_matrix = unname(ms_matrix),
                  mcd_obj = mcd_obj,
                  dirout_matrix = dir_out_matrix))
    } else{
      return(list(mean_outlyingness = unname(mean_dir_out),
                  var_outlyingness = unname(var_dir_out),
                  distance = distance,
                  ms_matrix = unname(ms_matrix),
                  mcd_obj = mcd_obj))
    }
  }
  else{
    if(return_dir_matrix){
      return(list(mean_outlyingness = unname(mean_dir_out),
                  var_outlyingness = unname(var_dir_out),
                  dirout_matrix = dir_out_matrix))
    }
    else{
      return(list(mean_outlyingness = unname(mean_dir_out),
                  var_outlyingness = unname(var_dir_out)))
    }
    
  }
  
}

croux_hesbroeck_asymptotic <- function(n, dimension){
  h <- floor((n+dimension+1)/2)
  alpha <- (n-h)/n
  q_alpha <- qchisq(1-alpha, dimension)
  c_alpha <- (1 - alpha)/pchisq(q_alpha, dimension + 2)
  c2 <- -pchisq(q_alpha, dimension+2)/2
  c3 <- -pchisq(q_alpha, dimension + 4)/2
  c4 <- 3*c3
  b1 <- c_alpha*(c3-c4)/(1-alpha)
  b2 <- 0.5 + c_alpha/(1-alpha)*(c3-q_alpha*(c2+(1-alpha)/2)/dimension)
  v1  <- (1-alpha)*(b1^2)*
    (alpha*(c_alpha*q_alpha/dimension-1)^2-1)-2*c3*c_alpha^2*
    (3*(b1-dimension*b2)^2+(dimension+2)*b2*(2*b1-dimension*b2))
  v2 <- n*(b1*(b1-dimension*b2)*(1-alpha))^2*c_alpha^2
  v <- v1/v2
  m_asy <- 2/(c_alpha^2*v)
  m <- m_asy*exp(0.725-0.00663*dimension-0.078*log(n))
  if (m < dimension){ #if m is >= dimension, then line 18 works, if not change m to m_asy
    m <- m_asy
  }
  a1 <- rchisq(10000,dimension + 2)
  a2 <- rchisq(10000,dimension, h/n)
  c <- sum(a1 < a2)/(10000*h/n)
  factors <- c * (m - dimension + 1)/(dimension * m)
  cutoff <- qf(0.993, dimension, m - dimension + 1)
  list(factor1 = factors, factor2 = cutoff)
}

hardin_factor_numeric <- function(n, dimension){
  if (dimension == 2){
      asymp_result <- croux_hesbroeck_asymptotic(n = n, dimension = dimension)
      factor1  <- asymp_result$factor1
      factor2 = asymp_result$factor2
    
  } else if (dimension == 3){
      asymp_result  <- croux_hesbroeck_asymptotic(n = n, dimension = dimension)
      factor1 <- asymp_result$factor1
      factor2 <- asymp_result$factor2
  } else if (dimension > 3){
    asymp_result  <- croux_hesbroeck_asymptotic(n = n, dimension = dimension)
    factor1 <- asymp_result$factor1
    factor2 <- asymp_result$factor2
  } else{
    stop("Argument \'dimension\' must be greater than or equal to 2.")
  }
  return(list(factor1 = factor1, factor2 = factor2))
}


msplot <- function(dts,
                   data_depth = c("random_projections"),
                   n_projections = 200, seed = NULL,
                   return_mvdir = TRUE,
                   plot = TRUE,
                   plot_title = "Magnitude Shape Plot",
                   title_cex = 1.5,
                   show_legend = T,
                   ylabel = "VO",
                   xlabel) {
  ### pairwise plots of variation of outlyingness (VO) against mean outlyingness (MO)###
  data_dim  <- dim(dts)
  #data_depth <- match.arg(data_depth)
  n <- data_dim[1]
  dir_result <- dir_out(dts, data_depth = data_depth,
                        n_projections = n_projections, seed = seed)
  
  if (length(data_dim) == 2){ # univariate
    dist <- dir_result$distance
    rocke_factors <- hardin_factor_numeric(n, 2)
    rocke_factor1 <- rocke_factors$factor1
    rocke_cutoff <- rocke_factors$factor2 # C in paper
    cutoff_value <- rocke_cutoff/rocke_factor1 #rocke_cutoff/rocke_factor1
    outliers_index <- which(dist > cutoff_value)
    median_curve <- which.min(dist)
    if (plot){
      # mo and vo
      myx <- dir_result$mean_outlyingness
      myy <- dir_result$var_outlyingness
      if(missing(xlabel)) xlabel <- "MO"
    }
    
  } else if (length(data_dim) == 3){ # multivariate
    d <- data_dim[3]
    rocke_factors  <- hardin_factor_numeric(n = n, dimension = d + 1)
    rocke_factor1 <- rocke_factors$factor1
    rocke_cutoff <- rocke_factors$factor2
    
    cutoff_value  <- rocke_cutoff/rocke_factor1
    outliers_index <- which(dir_result$distance > cutoff_value)
    median_curve <- which.min(dir_result$distance)
    
    if (plot){
      # mo and vo
      myx <- sqrt(rowSums(dir_result$mean_outlyingness^2, na.rm = T))
      myy <- dir_result$var_outlyingness
      if(missing(xlabel)) xlabel <- "||MO||"
    }
    
  }
  if(plot){
    # plot area
    plot(myx, myy, type = "n", xlab = xlabel,
         ylab = ylabel, xlim = range(myx) + c(-sd(myx), 1.5*sd(myx) ),
         ylim = range(myy) + c(-.2*sd(myy), 1*sd(myy) ), axes = F,
         col.lab = "gray20")
    #add axis
    axis(1, col = "white", col.ticks = "grey61", lwd.ticks = .5, tck = -0.025,
         cex.axis = 0.9, col.axis = "gray30")
    axis(2,col = "white", col.ticks = "grey61",  lwd.ticks = .5, tck = -0.025,
         cex.axis = 0.9, col.axis = "gray30")
    grid(col = "grey75", lwd = .3)
    box(col = "grey51")
    
    if(length(outliers_index > 0)){
      points(myx[-outliers_index], myy[-outliers_index], bg = "gray60", pch = 21)
      points(myx[outliers_index], myy[outliers_index], pch = 3)
    } else{
      points(myx, myy, bg = "gray60", pch = 21)
    }
    mtext(plot_title,3, adj = 0.5, line = 1, cex = title_cex, col = "gray20")
    # mtext(paste0(length(outliers_index), " outliers detected"),
    #       1, adj = 1, line = 3, cex =.8, font = 3, col = "gray41")
    if(show_legend){
      legend("topright", legend = c("normal", "outlier"),
             pch = c(21, 3), cex = 1,
             pt.bg = "gray60", col = "gray0",
             text.col = "gray30", bty = "n",
             box.lwd = .1, xjust = 0, inset = .01)
    }
  }
  
  
  if (return_mvdir){
    return(list(outliers = outliers_index,
                median_curve = median_curve,
                mean_outlyingness = dir_result$mean_outlyingness,
                var_outlyingness = dir_result$var_outlyingness))
    
    
  } else{
    return(list(outliers = outliers_index,
                median_curve = median_curve))
  }
  
}