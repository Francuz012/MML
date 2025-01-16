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
  #f_i = box_fun(x)
  
  for(i in 1:m){
    ti = i/10
    # f_i(x)
    fi_x <- exp(-ti*x[1]) - exp(-ti*x[2]) - x[3]*(exp(-ti) - exp(-10*ti))
    
    # parcijalni derivati f f_i wrt x1, x2, x3:
    dfi_dx1 <- -ti * exp(-ti*x[1])
    dfi_dx2 <-  ti * exp(-ti*x[2])
    dfi_dx3 <- -(exp(-ti) - exp(-10*ti))
    
    # Akumuliranje: gradijentna suma kvadrata = sum_i [ f_i * grad f_i ]
    grad_vec[1] <- grad_vec[1] + fi_x * dfi_dx1
    grad_vec[2] <- grad_vec[2] + fi_x * dfi_dx2
    grad_vec[3] <- grad_vec[3] + fi_x * dfi_dx3
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
  
  
  gamma <- (sqrt(5)-1) / 2
  
  iter_count <- 0
  
  while((alpha_R - alpha_L) > tol && iter_count < max_iter){
    #nalazenje zlatnog opsega
    alpha_1 <- alpha_L + (1-gamma) * (alpha_R - alpha_L)
    alpha_2 <- alpha_L + gamma * (alpha_R - alpha_L)
    
    f1 <- phi(alpha_1)
    f2 <- phi(alpha_2)
    
    if(f1 > f2){
      alpha_L <- alpha_1    #ako je f1 vece, onda minimum nije izmedju alpha_L i alpha_1, tako da pomerimo a_L na a_1
    } else{
      alpha_R <- alpha_2
    }
    
    iter_count <- iter_count + 1
  }
  
  #Kada je interval dovoljno mali (alpha_R - alpha_L <= tol) ili stigne do max_iter, tada odaberemo srednju tacku kao konacni alpha
  
  alpha_star <- (alpha_L + alpha_R) / 2
  
  return(alpha_star)
}

box_solver <- function(x0, m = 10, tol = 1e-6, max_iter = 1000){
  #x0 je pocetna pretpostavka
  
  x_curr <- x0
  
  for(iter in 1:max_iter){
    grad_curr <- box_grad(x_curr, m) #racunanje gradijenta
    
    #provera konvergencije gradijentnoj normom
    if(sqrt(sum(grad_curr^2)) < tol){
      cat("Konvergiralo je na iteraciji: ", iter, "\n")
      break
    }
    
    p <- -grad_curr #negativni gradijent za gradijent najbrzeg pada
    #unutar line_search_zlatni_presek postoji phi <- function(alpha) gde f(x + alpha * p), sto znaci da z <- (x+alpha*p)
    alpha <- line_search_zlatni_presek(x_curr, p, function(z) box_fun(z, m), tol = 1e-5, max_iter = 1000)
    
    x_curr <- x_curr + alpha * p
  }
  
  return(x_curr)
}

x0 <- c(0, 10, 5)
solution <- box_solver(x0, m = 10, tol = 1e-6, max_iter = 1000)

cat("Resenje:", solution, "\n")
cat("Ciljana vrednost kod resenja:", box_fun(solution, 10), "\n")



