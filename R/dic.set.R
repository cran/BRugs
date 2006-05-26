"dicSet" <-
function()
#   Set a monitor for dic
{
    command <- "DevianceEmbed.SetVariable('*');DevianceEmbed.SetGuard;DevianceEmbed.Set"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    if(getOption("BRugsVerbose")) 
        buffer()
}
