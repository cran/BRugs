"samplesGetThin" <-
function()
#   Get the thin field
{
    command <- "SamplesEmbed.thin"
    as.integer(.C("Integer", command, nchar(command), integer(1), 
        integer(1), PACKAGE="BRugs")[[3]])
}
