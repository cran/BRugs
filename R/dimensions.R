"dimensions" <-
function(node)
#   Get dimension information for quantity in OpenBUGS model
{
    nodeLabel <- as.character(node)
    if(!(nodeLabel %in% modelNames()))
        stop("node must be a variable name from the model")
    command <- "BugsRobjects.Set"
    .C("CharArray", command, nchar(command), as.character(nodeLabel),
        nchar(nodeLabel), integer(1), PACKAGE="BRugs")
    command <- "BugsRobjects.NumSlots"
    numSlots <- as.integer(.C("Integer", command, nchar(command), 
                              integer(1), integer(1), PACKAGE="BRugs")[3])
    dimensions <- integer(numSlots)
    command <- "BugsRobjects.Dimensions"
    if (numSlots > 0) 
        dimensions <- .C("IntegerArray", command, nchar(command),
                         as.integer(dimensions), as.integer(numSlots), 
                         integer(1), PACKAGE="BRugs")[[3]]
    else dimensions <- NULL
    return(dimensions)
}
