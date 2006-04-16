"samplesSetBeg" <-
function(begIt)
#   Set the beg field
{
    if(!is.numeric(begIt))
        stop("begIt ", "must be numeric")
    begIt <- as.integer(begIt)
    command <- paste("SamplesEmbed.beg :=", begIt)
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs"))
}
