"getChain" <-
function()
#   Get chain field
{
    command<- "BugsEmbed.chain"
    as.integer(.C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
