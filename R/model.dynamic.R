"modelEnableDynamic" <-
function()
#   Enable Dynamic Compilation
{
    command <- "BugsEmbed.CompiledGuard; BugsEmbed.EnableDynamic"
    invisible(.C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]])
}

"modelDisableDynamic" <-
function()
#   Disable Dynamic Compilation
{
    command <- "BugsEmbed.CompiledGuard; BugsEmbed.DisableDynamic"
    invisible(.C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]])
}
