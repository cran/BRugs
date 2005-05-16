"samplesSize" <-
function(node)
#   Size of stored sample of single component of OpenBUGS name
{
    nodeName <- sQuote(node)
    command <- paste("SamplesEmbed.SetVariable(", nodeName, ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "SamplesEmbed.SampleSize"
    as.integer(.C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
