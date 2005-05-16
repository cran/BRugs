"samplesGetEnd" <-
function()
#   Get the end field
{
    command <- "SamplesEmbed.end"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
