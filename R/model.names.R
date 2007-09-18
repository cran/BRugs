"modelNames" <-
function()
{
#   gets names in OpenBUGS model
    command <- "BugsRobjects.GetNumberNames"
    number <- .C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]]
    name <- character(number)
    if(length(number)){
        for(i in 1:number){
            command <- paste("BugsRobjects.SetIndex(", i-1, ")", sep="")
            .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
            command <- "BugsRobjects.GetStringLength"
            numchar <- .C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]]
            command <- "BugsRobjects.GetVariable"
            char <- paste(rep(" ", numchar), collapse="")
            name[i] <- .C("CharArray", command, nchar(command), char, numchar, integer(1), PACKAGE="BRugs")[[3]]
        }
    }
    return(name)
}
