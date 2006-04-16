"getNumChains" <-
function()
#   Get numChains field
{
    command<- "BugsEmbed.numChains"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
