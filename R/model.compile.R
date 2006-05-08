"modelCompile" <-
function(numChains = 1)
#   Compile OpenBUGS model
{
    if(!is.numeric(numChains))
        stop("numChains ", "must be numeric")
    numChains <- as.integer(numChains)
    command <- paste("BugsEmbed.CompileGuard",              
        ";BugsEmbed.numChains :=", as.character(numChains), "; BugsEmbed.Compile", sep = "")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    samplesSetFirstChain(1)
    samplesSetLastChain(numChains)
    if(getOption("BRugsVerbose")) 
        buffer()
}
