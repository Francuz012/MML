box_fun <- function(x, m = 10){
  f_vals <- numeric(m)
  for(i in 1:m){
    ti = i/10
    f_vals[i] = exp(-ti * x[1]) - exp(-ti * x[2]) - x[3] * (exp(-ti) - exp(-10 * ti))
  }
  return(0.5 * sum(f_vals^2))
}

box_grad <- function(x, m = 10){
  grad_vec <- numeric(3)
    f_i = box_fun(x)
  
  for(i in 1:m){
    ti = i/10
    grad_vec[1] = grad_vec[1] + f_i * (-ti*exp(-ti*x[1]))
    grad_vec[2] = grad_vec[2] + f_i * (ti*exp(-ti*x[2]))
    grad_vec[3] = grad_vec[3] + f_i * (-exp(-ti) + exp(-10*ti))
  }
  
  return(grad_vec)
}

line_search_zlatni_presek <- function(x, p, f, tol = 1e-5, max_iter = 100){
  #p je pravac kretanja
  #f je racunica box_fun(x)
  #tol je tolerancija zaustavljanja
  
  phi <- function(alpha){
    f(x+alpha*p)
  }
  
  alpha_L <- 0
  alpha_R <- 1  #moze se prosiriti ako phi(R) < phi(L), eventualno prosiriti do 2
  
  
  gama <- (sqrt(5)-1) / 2
  
  iter_count <- 0
  
  while((alpha_R - alpha_L) > tol && iter_count < max_iter){
    #nalazenje zlatnog opsega
    alpha_1 <- alpha_L + (1-gamma) * (alpha_R - alpha_L)
    alpha_2 <- alpha_L + gamma * (alpha_R - alpha_L)
    
  }
}
