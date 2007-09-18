"currentValues" <-  
function(nodeLabel)
# Get current value of node
{
    nodeLabel <- as.character(nodeLabel)
    command <- "BugsRobjects.SetVariable"
    len <- nchar(command)
    .C("CharArray", command, as.integer(len), nodeLabel, nchar(nodeLabel), integer(1), PACKAGE="BRugs")
    command <- "BugsRobjects.GetSize"
    nodeSize <- .C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[[3]]
    if(nodeSize == -1) 
        stop(nodeLabel, " is not a node in BUGS model")
    command <- "BugsRobjects.GetValues"
    .C("RealArray", command, nchar(command), as.real(rep(NA, nodeSize)), 
        as.integer(nodeSize), integer(1), NAOK = TRUE, PACKAGE="BRugs")[[3]]
}
