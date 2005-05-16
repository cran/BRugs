"summaryClear" <-
function(node)
#   Clear summary monitor for node in WinBUGS model
{
    nodeName <- sQuote(node)
    for(i in seq(along=nodeName)){
        command <- paste("SummaryEmbed.SetVariable(", nodeName[i], ") SummaryEmbed.StatsGuard",
                         "SummaryEmbed.Clear")
        .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
        buffer <- file.path(tempdir(), "buffer.txt")
        rlb <- readLines(buffer)
        cat("Variable ", nodeName[i], ": ", rlb, "\n", sep = "")
    }
    invisible()
}
