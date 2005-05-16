"summarySet" <-
function(node)
#   Set summary monitor for node in OpenBUGS model
{
    nodeName <- sQuote(node)
    for(i in seq(along=nodeName)){
        command <- paste("SummaryEmbed.SetVariable(", nodeName[i], "); SummaryEmbed.SetGuard",
                                "SummaryEmbed.Set")
        .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
        buffer <- file.path(tempdir(), "buffer.txt")
        rlb <- readLines(buffer)
        cat("Variable ", nodeName[i], ": ", rlb, "\n", sep = "")
    }
    invisible()    
}
