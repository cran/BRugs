"modelGetSeed" <-
function(i = 1)
#   Get the seed of random number generator
{
    if(!is.numeric(i))
        stop("i ", "must be numeric")
    command <- paste("BugsEmbed.index := ", as.integer(i), ";BugsEmbed.GetRNState")
    res <- .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")[[3]]
    if(res) stop("Getting seed returned with an error.")
    buffer()
}
