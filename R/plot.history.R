"plotHistory" <-
function(node, plot = TRUE, colour = c("red", "blue", "green", "yellow", "black"), 
    main = NULL, xlab = "iteration", ylab = "", ...)
#   Plot history for single component of OpenBUGS name
{
    sM <- samplesMonitors(node)
    if(length(sM) > 1 || sM != node)
        stop("node must be a scalar variable from the model, for arrays use samplesHistory")
    nodeName <- sQuote(node)
    command <- paste("SamplesEmbed.SetVariable(", nodeName, ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "SamplesEmbed.SampleSize"
    if (is.R()){
      sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[3])
    } else {
      sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE="BRugs")[3][[1]])
    }
    command <- "SamplesEmbed.SampleValues"
    if (is.R())
      sample <- .C("RealArray", command, nchar(command), real(sampleSize),
                   sampleSize, integer(1), PACKAGE="BRugs")[[3]]
    else
      sample <- .C("RealArray", command, nchar(command), double(sampleSize),
                   sampleSize, integer(1), PACKAGE="BRugs")[[3]]
    end <- min(c(modelIteration(), samplesGetEnd()))
    thin <- samplesGetThin()
    numChains <- samplesGetLastChain() - samplesGetFirstChain() + 1
    sampleSize <- sampleSize %/% numChains
    beg <- end - (sampleSize - 1) * thin
    beg <- beg %/% thin
    end <- end %/% thin
    x <- (beg:end) * thin
    y <- matrix(sample, ncol = numChains)
    if(plot){
        plot(x, y[,1], ylim = range(sample), type = "n", 
            main = if(is.null(main)) nodeName else main, 
            xlab = xlab , ylab = ylab, ...)
        for(chain in 1:numChains){
            lines(x, y[,chain], col = colour[chain], ...)
        }
        invisible(y)
    }
    else return(y)
}
