"plotDensity" <-
function(node, main = NULL, xlab = "" , ylab = "", col = "red", ...)
#   Plot posterior density for single component of OpenBUGS name
{
    sM <- samplesMonitors(node)
    if(length(sM) > 1 || sM != node)
        stop("node must be a scalar variable from the model, for arrays use samplesDensity")
    nodeName <- sQuote(node)
    command <- paste("SamplesEmbed.SetVariable(", nodeName, ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    command <- "SamplesEmbed.SampleSize"
    sampleSize <- as.integer(.C("Integer", command, nchar(command), 
                                integer(1), integer(1), PACKAGE="BRugs")[[3]])
    command <- "SamplesEmbed.SampleValues"
    if (is.R())
      sample <- .C("RealArray", command, nchar(command), real(sampleSize),
                   as.integer(sampleSize), integer(1), PACKAGE="BRugs")[[3]]
    else 
      sample <- .C("RealArray", command, nchar(command), double(sampleSize),
                   as.integer(sampleSize), integer(1), PACKAGE="BRugs")[[3]]
    
    absSample <- abs(sample)
    intSample <- as.integer(absSample + 1.0E-10)
    zero <- absSample - intSample
    intSample <- as.integer(sample)
    if (sum(zero) > 0){
        if (is.R())
          d <- density(sample, adjust = 1.25)
        else
          d <- density(sample)
        plot(d$x, d$y, type = "l", main = if(is.null(main)) nodeName else main, 
            xlab = xlab , ylab = ylab, col = col, ...)
    }
    else{
        histogram <- table(intSample) / sampleSize
        xRange <- range(intSample)
        xLim <- c(xRange[1] - 0.5, xRange[2] + 0.5)
        plot(histogram, type = "h", xlim = xLim, ylim = c(0, 1), 
            main = if(is.null(main)) nodeName else main, 
            xlab = xlab , ylab = ylab, col = col, ...)
    }
}
