"modelGenInits" <-
function()
#   Generate initial values for OpenBUGS model
{
    command <- paste("BugsEmbed.GenerateInitsGuard;",  "BugsEmbed.GenerateInits")
    .C("CmdInterpreter", command, nchar(command), 
        integer(1), PACKAGE="BRugs")
    buffer()
}
