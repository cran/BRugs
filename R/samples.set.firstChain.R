"samplesSetFirstChain" <-
function(first)
#   Set the firstChain field
{
    if(!is.numeric(first))
        stop("first ", "must be numeric")
    first <- as.integer(first)
    if(!(first %in% 1:getNumChains()))
        stop("it is required to have 1 <= first <= nchains")
    command <- paste("SamplesEmbed.firstChain := ", as.integer(first))
    invisible(.C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs"))
}
