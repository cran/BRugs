"modelIteration" <-
function()
#   Get iteration field
{
    command <- "BugsEmbed.iteration"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
