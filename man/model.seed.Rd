\name{modelSeed}
\alias{modelSetSeed}
\alias{modelGetSeed}
\title{Seed of Random Number Generator}
\description{These functions set/return the seed of the random number generator.}
\usage{
modelSetSeed(newSeed)
modelGetSeed(i = 1)
}
\arguments{
  \item{newSeed}{a positive, non zero (vector of) integer(s). 
    More than one integer if the chosen random number generator requires more seed components.}
  \item{i}{indicates which component of the seed should be returned.}
}
\seealso{\code{\link{BRugs}}, \code{\link{help.WinBUGS}}}
\keyword{interface}
\concept{update}
\concept{iteration}
\concept{seed}
\concept{random}
