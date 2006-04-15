"modelPrecision" <-
function(prec)
#   Set the precision to which results are displayed
{
    if(!is.numeric(prec))
        stop("prec ", "must be numeric")
    prec <- as.integer(prec)
    command <- paste("BugsMappers.SetPrec(", prec, ")")
    invisible(.C("CmdInterpreter", command, nchar(command), 
        integer(1), PACKAGE="BRugs"))
}
