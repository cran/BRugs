"samplesSample" <-
function(node)
#   Get stored sample for single component of OpenBUGS name
{
    if(samplesGetFirstChain() > samplesGetLastChain())
        stop("Number of first chain is larger than last chain!")
    command <- paste("SamplesEmbed.SetVariable(", sQuote(node), ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "SamplesEmbed.SampleSize"
    sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[[3]])
    command <- "SamplesEmbed.Sample"
    .C("RealArray", command, nchar(command), 
        real(sampleSize), sampleSize, integer(1), PACKAGE="BRugs")[[3]]
}
