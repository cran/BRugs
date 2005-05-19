"dicClear" <-
function()
#   Clear monitor for dic
{
    command <- "DevianceEmbed.StatsGuard;DevianceEmbed.Clear"
    invisible(.C("CmdInterpreter", command, nchar(command), 
        integer(1), PACKAGE="BRugs"))
}
