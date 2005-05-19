"getGraphObj" <-
function(node)
#   Get type of GraphNode objects
{
    command <- paste("BugsEmbed.SetVariable(", sQuote(node), "); BugsEmbed.Nodes")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    read.table(buffer)
}
