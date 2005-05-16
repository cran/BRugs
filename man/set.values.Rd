\name{setValues}
\alias{setValues}
\title{Setting current values}
\description{This function sets current values for a variable for future iterations.}
\usage{
setValues(nodeLabel, values)
}
\arguments{
  \item{nodeLabel}{Character vector of length 1, name of a variable in the model.}
  \item{values}{The values to be set, generated, e.g., by \code{\link{currentValues}}.}
}
\details{
\code{\link{currentValues}} of a model can be stored in order to be used as initial values.
}
\value{The number of values set.}
\seealso{\code{\link{currentValues}}, \code{\link{BRugs}}, \code{\link{help.WinBUGS}}}
\keyword{interface}


