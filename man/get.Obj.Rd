\name{getObj}
\alias{getGraphObj}
\alias{getUpdaterObj}
\title{Expert functions}
\description{Getting class names of Component Pascal object}
\usage{
getGraphObj(node)
getUpdaterObj(node)
}
\arguments{
  \item{node}{Character vector of length 1, name of a variable in the model.}
}
\details{
OpenBUGS creates Component Pascal objects to represent each component of a name in the graphial model. 
}
\value{
\code{getGraphObj} returns a data frame of the class names of the Component Pascal object associated with each component. 

\code{getUpdaterObj} returns a data frame of the class names of the Component Pascal object 
for each component of a variable that needs updating.
}
\seealso{\code{\link{BRugs}}, \code{\link{help.WinBUGS}}}
\keyword{interface}







