"samplesSetThin" <-
function(thin)
#   Set the thin field
{
    if(!is.numeric(thin))
        stop("thin ", "must be numeric")
    command <- paste("SamplesEmbed.thin :=", as.integer(thin))
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs"))
}
