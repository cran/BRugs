"samplesGetBeg" <-
function()
#   Get the beg field
{
    command <- "SamplesEmbed.beg"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
