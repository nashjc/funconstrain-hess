% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/11_gulf.R
\name{gulf}
\alias{gulf}
\title{Gulf Research and Development Function}
\usage{
gulf(m = 99)
}
\arguments{
\item{m}{Number of summand functions in the objective function. Should be
between 3 and 100, according to the MGH paper. Default value is 99, which
Jamil and Xang (2013) list as the only valid value.}
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
  \item \code{x0} Standard starting point.
  \item \code{fmin} reported minimum
  \item \code{xmin} parameters at reported minimum
}
}
\description{
Test function 11 from the More', Garbow and Hillstrom paper.
}
\details{
The objective function is the sum of \code{m} functions, each of \code{n}
parameters.

\itemize{
  \item Dimensions: Number of parameters \code{n = 3}, number of summand
  functions \code{3 <= m <= 100}.
  \item Minima: \code{f = 0} at \code{(50, 25, 1.5)}.
}

Note that the equation as published by More', Garbow and Hillstrom (1981)
contains an error, where the symbol 'mi' should be interpreted as a minus
sign. The corrected version can be found in Jamil and Xang (2013), and no
doubt several other publications. The Jamil and Xang equation unfortunately
contains its own minor errors, but you can piece together the correct
equation from these two sources without too much trouble.
}
\examples{
# Use 10 summand functions
fun <- gulf(m = 10)
# Optimize using the standard starting point
x0 <- fun$x0
res_x0 <- stats::optim(par = x0, fn = fun$fn, gr = fun$gr, method =
"L-BFGS-B")
# Use your own starting point
res <- stats::optim(c(0.1, 0.2, 0.3), fun$fn, fun$gr, method = "L-BFGS-B")

# Use 20 summand functions
fun20 <- gulf(m = 20)
res <- stats::optim(fun20$x0, fun20$fn, fun20$gr, method = "L-BFGS-B")
}
\references{
More', J. J., Garbow, B. S., & Hillstrom, K. E. (1981).
Testing unconstrained optimization software.
\emph{ACM Transactions on Mathematical Software (TOMS)}, \emph{7}(1), 17-41.
\doi{doi.org/10.1145/355934.355936}

Jamil, M., & Yang, X. S. (2013).
A literature survey of benchmark functions for global optimisation problems.
\emph{International Journal of Mathematical Modelling and Numerical
Optimisation}, \emph{4}(2), 150-194.
\doi{doi.org/10.1504/IJMMNO.2013.055204}
\doi{arxiv.org/abs/1308.4008}
}
