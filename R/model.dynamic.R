"modelEnableDynamic" <-
function()
#   Enable Dynamic Compilation
{
    command <- "BugsEmbed.CompiledGuard; BugsEmbed.EnableDynamic"
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")[[3]])
}

"modelDisableDynamic" <-
function()
#   Disable Dynamic Compilation
{
    command <- "BugsEmbed.CompiledGuard; BugsEmbed.DisableDynamic"
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")[[3]])
}
