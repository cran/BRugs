"samplesSetEnd" <-
function(endIt)
#   Set the end field
{
    if(!is.numeric(endIt))
        stop("endIt ", "must be numeric")
    endIt <- as.integer(endIt)
    command <- paste("SamplesEmbed.end := ", endIt)
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs"))
}
