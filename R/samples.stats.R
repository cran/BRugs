"samplesStats" <-
function(node, beg = samplesGetBeg(), end = samplesGetEnd(), 
firstChain = samplesGetFirstChain(), lastChain = samplesGetLastChain(), 
thin = samplesGetThin())
#   Calculate statistics for monitored node                 
{
    oldBeg <- samplesGetBeg()
    oldEnd <- samplesGetEnd()
    oldFirstChain <- samplesGetFirstChain()
    oldLastChain <- samplesGetLastChain()
    oldThin <- samplesGetThin()
    on.exit({
        samplesSetBeg(oldBeg)
        samplesSetEnd(oldEnd)
        samplesSetFirstChain(oldFirstChain)
        samplesSetLastChain(oldLastChain)
        samplesSetThin(oldThin)
    })    
    samplesSetBeg(beg)
    samplesSetEnd(end)
    samplesSetFirstChain(firstChain)
    samplesSetLastChain(lastChain)
    thin <- max(c(thin, 1))
    samplesSetThin(thin)
    nodeName <- sQuote(node)
    
    
    result <- data.frame(mean=NULL, sd=NULL, MC_error = NULL, val2.5pc=NULL, 
                         median=NULL, val97.5pc=NULL, start = NULL, sample=NULL)
    for(i in seq(along=nodeName)){
        command <- paste("SamplesEmbed.SetVariable(", nodeName[i], 
        ");SamplesEmbed.StatsGuard;SamplesEmbed.Stats")
        .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
        buffer <- file.path(tempdir(), "buffer.txt")
        rlb <- readLines(buffer)
        len <- length(rlb)
        if (len > 1)
            result <- rbind(result, read.table(buffer))
        else{
            if(length(grep("val97.5pc", rlb)))
                message("Variable ", nodeName[i], " has probably not been updated")
            else
                message("Variable ", nodeName[i], ": ", rlb)
        }
    }
    return(result)
}
