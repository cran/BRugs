"ranksStats" <-
function(node)
#   Calculates ranks statistics for vector valued node in OpenBUGS model
{
    if(length(node) > 1 || node == "*")
        stop("node cannot be a vector, nor '*'")
    nodeName <- sQuote(node)
    command <- paste("RanksEmbed.SetVariable(", nodeName, ") RanksEmbed.StatsGuard",
                             "RanksEmbed.Stats")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    rlb <- readLines(buffer)
    len <- length(rlb)
    if (len > 1) 
        read.table(buffer)
    else
        cat(rlb, "\n")
}
