"samplesClear" <-
function(node)
#   Clear a sample monitor
{
    nodeName <- sQuote(node)
    command <- paste("SamplesEmbed.SetVariable(", nodeName, 
                            ");SamplesEmbed.HistoryGuard;SamplesEmbed.Clear")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    if(getOption("BRugsVerbose")) 
        buffer()
}
