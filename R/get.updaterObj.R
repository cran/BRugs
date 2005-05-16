"getUpdaterObj" <-
function(node)
#   Get type of UpdaterUpdaters objects
{
    command <- paste("BugsEmbed.SetVariable(", sQuote(node), "); BugsEmbed.Methods")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    read.table(buffer)
}
