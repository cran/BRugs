"bgrPoint" <-
function(node, iteration)
# Calculate the bgr statistic at iteration
{
    oldEnd <- samplesGetEnd()
    on.exit(samplesSetEnd(oldEnd))
    samplesSetEnd(as.integer(iteration))
    numChains <- getNumChains()
    command <- paste("SamplesEmbed.SetVariable(", sQuote(node), ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "SamplesEmbed.SampleSize"
    sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
    command <- "SamplesEmbed.Sample"
    sample <- .C("RealArray", command, nchar(command), real(sampleSize),
                 as.integer(sampleSize), integer(1), PACKAGE="BRugs")[[3]]
    lenChain <- sampleSize %/% numChains
    dq <- quantile(sample, c(0.1, 0.9), names = FALSE)
    d.delta <- dq[2] - dq[1]
    n.delta <- 0
    for (i in 1:numChains) {
        nq <- quantile(sample[((i - 1) * lenChain + 1) : (i * lenChain)], c(0.1, 0.9), names = FALSE)
        n.delta <- n.delta + nq[2] - nq[1]
    }
    n.delta <- n.delta / numChains
    bgr.stat <- d.delta / n.delta
    return(c(iteration, n.delta, d.delta, bgr.stat))
}
