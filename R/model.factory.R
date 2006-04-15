modelDisable <- function(factory){
    command <- paste("UpdaterMethods.SetFactory('", factory,"');UpdaterMethods.Disable", sep = "")
    invisible(.C("CmdInterpreter", comand, nchar(command), integer(1)))

}


modelEnable <- function(factory){
    command <- paste("UpdaterMethods.SetFactory('", factory,"');UpdaterMethods.Enable", sep = "")
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1)))
}
