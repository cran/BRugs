"modelGetSeed" <-
function()
#   Get the seed of random number generator
{
    command <- "BugsEmbed.GetSeed"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "BugsEmbed.newSeed"
    as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
