"getNumChains" <-
function()
#   Get numChains field
{
    command<- "BugsInterface.numChains"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
