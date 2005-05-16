"summaryStats" <-
function(node)
#   Calculates statistics for summary monitor associated with node in OpenBUGS model
{
    nodeName <- sQuote(node)
    result <- data.frame(mean=NULL, sd=NULL, val2.5pc=NULL, 
                         median=NULL, val97.5pc=NULL, sample=NULL)
    for(i in seq(along=nodeName)){
        command <- paste("SummaryEmbed.SetVariable(", nodeName[i], ") SummaryEmbed.StatsGuard",
                         "SummaryEmbed.Stats")
        .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
        buffer <- file.path(tempdir(), "buffer.txt")
        rlb <- readLines(buffer)
        len <- length(rlb)
        if (len > 1)
            result <- rbind(result, read.table(buffer))
        else{
            if(length(grep("val97.5pc", rlb)))
                cat("Variable", nodeName[i], "has probably not been updated\n")
            else
                cat("Variable ", nodeName[i], ": ", rlb, "\n", sep = "")
        }
    }
    return(result)
}
