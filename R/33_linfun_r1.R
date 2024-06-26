#' Linear Function - Rank 1
#'
#' Test function 33 from the More', Garbow and Hillstrom paper.
#'
#' The objective function is the sum of \code{m} functions, each of \code{n}
#' parameters.
#'
#' \itemize{
#'   \item Dimensions: Number of parameters \code{n} variable, number of
#'   summand functions \code{m >= n}.
#'   \item Minima: \code{f = (m * (m - 1)) / (2 * (2 * m + 1))} at any set of
#'   points \code{x[j]} with \code{j = 1, 2, ..., n} where the sum of
#'   \code{j * x[j] = 3 / (2 * m + 1)}.
#' }
#'
#' The number of parameters, \code{n}, in the objective function is not
#' specified when invoking this function. It is implicitly set by the length of
#' the parameter vector passed to the objective and gradient functions that this
#' function creates. See the 'Examples' section.
#'
#' @param m Number of summand functions in the objective function. Should be
#'   equal to or greater than \code{n}.
#' @return A list containing:
#' \itemize{
#'   \item \code{m} The number of functions to sum. Default is 100.
#'   \item \code{fn} Objective function which calculates the value given input
#'   parameter vector.
#'   \item \code{gr} Gradient function which calculates the gradient vector
#'   given input parameter vector.
#'   \item \code{he} If available, the hessian matrix (second derivatives)
#'   of the function w.r.t. the parameters at the given values.
#'   \item \code{fg} A function which, given the parameter vector, calculates
#'   both the objective value and gradient, returning a list with members
#'   \code{fn} and \code{gr}, respectively.
#'   \item \code{x0} Function returning the standard starting point, given
#'   \code{n}, the number of variables desired.
#'   \item \code{fmin} reported minimum
#'   \item \code{xmin} parameters at reported minimum
#' }
#' @references
#' More', J. J., Garbow, B. S., & Hillstrom, K. E. (1981).
#' Testing unconstrained optimization software.
#' \emph{ACM Transactions on Mathematical Software (TOMS)}, \emph{7}(1), 17-41.
#' \doi{doi.org/10.1145/355934.355936}
#'
#' @examples
#' linr1 <- linfun_r1(m = 10)
#' # 6 variable problem using the standard starting point
#' x0_6 <- linr1$x0(n = 6)
#' res_6 <- stats::optim(x0_6, linr1$fn, linr1$gr, method = "L-BFGS-B")
#' # Standing starting point with 8 variables
#' res_8 <- stats::optim(linr1$x0(8), linr1$fn, linr1$gr, method = "L-BFGS-B")
#' # Create your own 4 variable starting point
#' res_4 <- stats::optim(c(0.1, 0.2, 0.3, 0.4), linr1$fn, linr1$gr,
#'                       method = "L-BFGS-B")
#' # Use 20 summand functions
#' linr1_m20 <- linfun_r1(m = 20)
#' # Repeat 4 parameter optimization with new test function
#' res_n4_m20 <- stats::optim(c(0.1, 0.2, 0.3, 0.4), linr1_m20$fn, linr1_m20$gr,
#' method = "L-BFGS-B")
#' @export
linfun_r1 <- function(m = 100) {
  list(
    m = m, 
    fn = function(par) {
      n <- length(par)
      if (n < 1) {
        stop("Linear Function - Rank 1: n must be positive")
      }
      if (m < n) {
        stop("Linear Function - Rank 1: m must be >= n")
      }
      sum_jx <- sum(1:n * par)
      fi <- 1:m * sum_jx - 1
      sum(fi * fi)
    },
    gr = function(par) {
      n <- length(par)
      if (n < 1) {
        stop("Linear Function - Rank 1: n must be positive")
      }
      if (m < n) {
        stop("Linear Function - Rank 1: m must be >= n")
      }
      sum_jx <- sum(1:n * par)
      fi <- 1:m * sum_jx - 1
      2 * 1:n * sum(1:m * fi)
    },
    he = function(x) { 
       n <- length(x)
       h <- matrix(0.0, nrow=n, ncol=n)
       s1 <- 0.0
       for (i in 1:m) {
          s1 <- s1 + i^2
       }
       s1 <- 2.0*s1
       
       for (j in 1:n) {
          for (i in 1:j) {
             h[i,j] <- i*j*s1
          }
       }

       for (j in 1:(n-1)) { # symmetrize
         for (k in (j+1):n) {
           h[k,j] <- h[j,k]        
         }
       }
       h
    },
    fg = function(par) {
      n <- length(par)
      if (n < 1) {
        stop("Linear Function - Rank 1: n must be positive")
      }
      if (m < n) {
        stop("Linear Function - Rank 1: m must be >= n")
      }
      sum_jx <- sum(1:n * par)
      fi <- 1:m * sum_jx - 1
      fsum <- sum(fi * fi)
      grad <- 2 * 1:n * sum(1:m * fi)
      list(
        fn = fsum,
        gr = grad
      )
    },
    x0 = function(n = 45) {
      if (n < 1) {
        stop("Linear Function - Rank 1: n must be positive")
      }
      if (m < n) {
        stop("Linear Function - Rank 1: m must be >= n")
      }
      rep(1, n)
    },
    fmin = 24.62687,
    xmin = c(0.72754410, 0.4550882, 0.18263229, -0.08982361, -0.3622795) # n = 5 case
  )
}
