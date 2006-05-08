"loadModule" <-
function(module)
#           Load module
{
    command <- as.character(module)
    .C("Load", command, nchar(command), integer(1), PACKAGE="BRugs")
    if(getOption("BRugsVerbose")) 
        buffer()
}
