"modelAdaptivePhase" <-
function()
#   Get endOfAdapting field
{
    command <- "BugsInterface.endOfAdapting"
    (as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])) - 1
}
