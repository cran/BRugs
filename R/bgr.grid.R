"bgrGrid" <-
function(node, bins = 50)
# Calculate grid of points at which to evaluate bgr statistic
{
    command <- paste("SamplesEmbed.SetVariable(", sQuote(node), ") END")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- paste("SamplesEmbed.SampleSize")
    sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
    beg <- samplesGetBeg()
    end <- min(c(samplesGetEnd(), modelIteration()))
    numChains <- samplesGetLastChain() - samplesGetFirstChain() + 1
    sampleSize <- sampleSize %/% numChains
    beg <- end - (sampleSize - 1) 
    delta <- sampleSize %/% bins
    grid <- ((1 : (bins - 1)) * delta) + beg
    grid <- c(grid, end)
    grid
}
