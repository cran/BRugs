"modelSetOR" <-
function(factoryName, overRelaxation)
#   Set the length of adaptive phase
{
    name <- sQuote(factoryName)
    command <- paste("UpdaterMethods.SetFactory(", name, 
                     ") ;UpdaterMethods.OverRelaxationGuard;",
                     "UpdaterMethods.SetOverRelaxation(", 
                     overRelaxation,
                     ")", sep = "")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
}
