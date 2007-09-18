"setValues" <- function(nodeLabel, values)
# set value of node
{
    nodeLabel <- as.character(nodeLabel)
# NA handling, now internal in OpenBUGS?
#    cv <- currentValues(nodeLabel)
#    DoNotSetNA <- is.na(values) & !is.na(cv)
#    if(any(DoNotSetNA))
#        warning("Some NA values formerly had a non-NA value -- left unchanged")
#    values[DoNotSetNA] <- cv[DoNotSetNA]
    command <- "BugsRobjects.SetVariable"
    .C("CharArray", command, nchar(command), nodeLabel, nchar(nodeLabel), integer(1), PACKAGE="BRugs")
    command <- "BugsRobjects.GetSize"
    nodeSize <- .C("Integer", command, nchar(command), integer(1), integer(1), PACKAGE="BRugs")[3]
    if(nodeSize == -1)
        stop(nodeLabel, " is not a node in BUGS model")
    if(length(values) != nodeSize)
        stop("length(values) does not correspond to the node size")
    command <- "BugsRobjects.SetValues"
    .C("RealArray", command, nchar(command), as.real(values), as.integer(nodeSize), 
        integer(1), NAOK = TRUE, PACKAGE="BRugs")
}
