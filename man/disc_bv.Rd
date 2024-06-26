% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/28_disc_bv.R
\name{disc_bv}
\alias{disc_bv}
\title{Discrete Boundary Value Function}
\usage{
disc_bv()
}
\value{
A list containing:
\itemize{
  \item \code{fn} Objective function which calculates the value given input
  parameter vector.
  \item \code{gr} Gradient function which calculates the gradient vector
  given input parameter vector.
  \item \code{he} If available, the hessian matrix (second derivatives)
  of the function w.r.t. the parameters at the given values.
  \item \code{fg} A function which, given the parameter vector, calculates
  both the objective value and gradient, returning a list with members
  \code{fn} and \code{gr}, respectively.
  \item \code{x0} Function returning the standard starting point, given
  \code{n}, the number of variables desired.
  \item \code{fmin} reported minimum
  \item \code{xmin} parameters at reported minimum
}
}
\description{
Test function 28 from the More', Garbow and Hillstrom paper.
}
\details{
The objective function is the sum of \code{m} functions, each of \code{n}
parameters.

\itemize{
  \item Dimensions: Number of parameters \code{n} variable, number of summand
  functions \code{m = n}.
  \item Minima: \code{f = 0}.
}

The number of parameters, \code{n}, in the objective function is not
specified when invoking this function. It is implicitly set by the length of
the parameter vector passed to the objective and gradient functions that this
function creates. See the 'Examples' section.
}
\examples{
dbv <- disc_bv()
# 6 variable problem using the standard starting point
x0_6 <- dbv$x0(6)
res_6 <- stats::optim(x0_6, dbv$fn, dbv$gr, method = "L-BFGS-B")
# Standing starting point with 8 variables
res_8 <- stats::optim(dbv$x0(8), dbv$fn, dbv$gr, method = "L-BFGS-B")
# Create your own 4 variable starting point
res_4 <- stats::optim(c(0.1, 0.2, 0.3, 0.4), dbv$fn, dbv$gr,
                      method = "L-BFGS-B")
}
\references{
More', J. J., Garbow, B. S., & Hillstrom, K. E. (1981).
Testing unconstrained optimization software.
\emph{ACM Transactions on Mathematical Software (TOMS)}, \emph{7}(1), 17-41.
\doi{doi.org/10.1145/355934.355936}

More', J. J., & Cosnard, M. Y. (1979).
Numerical solution of nonlinear equations.
\emph{ACM Transactions on Mathematical Software (TOMS)}, \emph{5}(1), 64-85.
\doi{doi.org/10.1145/355815.355820}
}
