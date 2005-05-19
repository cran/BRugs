"modelSetIts" <-
function(factoryName, iterations)
#   Set the length of adaptive phase
{
    name <- sQuote(factoryName)
    command <- paste("UpdaterMethods.SetFactory(", name, 
                     ") ;UpdaterMethods.IterationsGuard;",
                     "UpdaterMethods.SetIterations(", 
                     iterations,
                     ")", sep = "")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
}
