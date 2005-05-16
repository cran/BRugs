"samplesCorrel" <-
function(node0, node1, beg = samplesGetBeg(), end = samplesGetEnd(), 
firstChain = samplesGetFirstChain(), lastChain = samplesGetLastChain(), 
thin = samplesGetThin())
#   Correlation matrix of two quantities in OpenBUGS model
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

    command <- paste("CorrelEmbed.SetVariable0(", sQuote(node0),
                            ");CorrelEmbed.SetVariable1(", sQuote(node1), 
                            ");CorrelEmbed.Guard", ";CorrelEmbed.PrintMatrix")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")

    buffer <- file.path(tempdir(), "buffer.txt")
    rlb <- readLines(buffer)
    len <- length(rlb)
    if (len > 1)
        as.matrix(read.table(buffer))
    else
        cat(rlb, "\n")
}
