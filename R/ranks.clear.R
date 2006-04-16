"ranksClear" <-
function(node)
#   Clears a ranks monitor for vector quantity in OpenBUGS model
{
    nodeName <- sQuote(node)
    command <- paste("RanksEmbed.SetVariable(", nodeName, "); RanksEmbed.StatsGuard;",
                                 "RanksEmbed.Clear")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer()
}
