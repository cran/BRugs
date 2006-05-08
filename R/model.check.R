"modelCheck" <-
function(fileName)
#   Check that OpenBUGS model is syntactically correct
{
    path <- dirname(fileName)
    path <- if(path == ".") getwd() else path
    fileName <- file.path(path, basename(fileName))
    if(!file.exists(fileName))
        stop("File ", fileName, " does not exist")
    if(file.info(fileName)$isdir) 
        stop(fileName, " is a directory, but a file is required")
    command <- paste("BugsEmbed.SetFilePath(", sQuote(fileName), 
        ");BugsEmbed.ParseGuard;BugsEmbed.Parse", sep = "")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    if(getOption("BRugsVerbose")) 
        buffer()
}
