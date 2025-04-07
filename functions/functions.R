# create function to calculate DFT
fdft <- function(x, w) { 
  # x: time series data (vector)
  # w: frequency
  N <- length(x)
  result <- 0
  for (k in 1:N) {
    result <- x[k] * exp(-1i * 2* pi* k* w) + result
  }
  return(result/sqrt(2*pi*N))
}

# create function to get real part of DFT under each frequency
freal <- function(data, w){
  # data: weakly stationary time series matrix
  # w: frequency
  p <- ncol(data)
  library(stats)
  dft_result <- apply(data, 2, function(x)fdft(x,w))
  real_part <- Re(dft_result)
  imag_part <- Im(dft_result)
  U <- c(real_part, imag_part)
  A <- cbind(diag(p), diag(p))
  V <- A %*% U
  Sigma_hat <- V %*% t(V)
  return(Sigma_hat)
}

# create function to conduct parametric bootstrap
f_para_boot <- function(x, alpha, B){
  # x: real part of spectral density (a matrix)
  # alpha: significance level
  # B: number of iteration
  p <- ncol(x)
  # load package
  library(MASS) 
  # Create empty matrices to save outputs
  V_boot <- matrix(0,p,B)#
  var_V = array(NA, dim = c(p, p, B))
  lb <- matrix(NA, nrow = p, ncol = p)
  ub <- matrix(NA, nrow = p, ncol = p)
  for (k in 1:B){
    set.seed(24*k)
    V_boot[,k] <- mvrnorm(n = 1, mu = rep(0, p), Sigma = x)
    var_V[,,k] = V_boot[,k]%*%t(V_boot[,k])
  }
  for (i in 1:p) {
    for (j in 1:p) {
      bootstrap_values <- var_V[i,j,]
      bootstrap_residuals <- bootstrap_values - x[i,j]
      lb[i, j] <- ifelse(x[i,j]- quantile(bootstrap_residuals, 1-alpha/2) > -10^-3, 0, x[i,j]- quantile(bootstrap_residuals, 1-alpha/2))
      ub[i, j] <-  ifelse(x[i,j] - quantile(bootstrap_residuals, alpha/2) < 10^-3, 0, x[i,j] - quantile(bootstrap_residuals, alpha/2))
    }
  }
  return(list(lb = lb, est = x, ub = ub))
}

# wrap up function
f_all <- function(x, y, alpha){
  #x: standardized time series matrix
  #y: 1 to length(freq0)
  #alpha: significance level
  Sigma_hat <- freal(x, w=freq0[y])
  result0 <- f_para_boot(Sigma_hat, alpha, 1000) # range: 0.01 - 0.0001
  result1 <- (!(result0$lb<0 & result0$ub>0))*1
  diag(result1) <- 0
  return(result1)
}
