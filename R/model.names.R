"modelNames" <-
function()
{
#   gets names in OpenBUGS model
    command <- "BugsRobjects.Names"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    readLines(buffer)
}
