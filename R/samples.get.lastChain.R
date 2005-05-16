"samplesGetLastChain" <-
function()
#   Get the lastChain field
{
    command <- "SamplesEmbed.lastChain"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
