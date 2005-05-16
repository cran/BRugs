"samplesGetFirstChain" <-
function()
#   Get the firstChain field
{
    command <- "SamplesEmbed.firstChain"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
