\name{bugsData}
\alias{bugsData}
\title{Writing input for OpenBUGS}
\description{Write data file for OpenBUGS.}
\usage{
bugsData(data, fileName = file.path(getwd(), "data.txt"), digits = 5)
}
\arguments{
  \item{data}{either a named list (names corresponding to variable names in the model file)
    of the data for the OpenBUGS model, \emph{or}
    a vector or list of the names of the data objects used by the model}
  \item{fileName}{the filename, defaults to \file{data.txt} in the current working directory}
  \item{digits}{number of significant digits used for OpenBUGS input, see \code{\link{formatC}}}
}
\value{
    Invisibly returns the \code{fileName}.
}
\seealso{\code{\link{BRugs}}}
\keyword{file}
