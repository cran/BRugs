"modelModules" <-
function()
#   List loaded OpenBUGS components
{
    command <- "BugsEmbed.Modules"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    read.table(buffer)
}
