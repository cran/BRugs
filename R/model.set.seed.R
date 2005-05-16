"modelSetSeed" <-
function(newSeed)
#   Set the seed of random number generator
{
    if(!is.numeric(newSeed))
        stop("newSeed ", "must be numeric")
    newSeed <- as.integer(newSeed)
    command <- paste("BugsEmbed.newSeed := ", newSeed)
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "BugsEmbed.SetSeedGuard; BugsEmbed.SetSeed"
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs"))
}
