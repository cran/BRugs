"samplesMonitors" <-
function(node)
#   List all sample monitors corresponding to node
{
    command <- paste("SamplesEmbed.SetVariable(", sQuote(node), 
        ");SamplesEmbed.StatsGuard;SamplesEmbed.Labels")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    rlb <- readLines(buffer)
    len <- length(rlb)
    if (len == 1 && rlb == "command is not allowed (greyed out)")
        message(rlb)
    else{
        if(len == 0){
            message("model has probably not yet been updated")
            invisible("model has probably not yet been updated")
        }
        else
            scan(buffer, what = "character", quiet = TRUE, sep="\n")
    }
}
