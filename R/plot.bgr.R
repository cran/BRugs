"plotBgr" <-
function(node, plot = TRUE, main = NULL, xlab = "iteration", ylab = "bgr", 
    col = c("red", "blue", "green"), bins = 50, ...)
#   Plot bgr diagnostic for single component of OpenBUGS name
{
    sM <- samplesMonitors(node)
    if(length(sM) > 1 || sM != node)
        stop("node must be a scalar variable from the model, for arrays use samplesBgr")
    grid <- bgrGrid(node, bins = bins)
    bgr <- sapply(grid, bgrPoint, node = node)
    yRange <- range(bgr[4,])
    yRange <- c(0, max(c(1.2, yRange[2])))
    nRange <- range(bgr[2,])
    nRange <- c(min(c(0, nRange[1])), nRange[2])
    nDelta <- nRange[2] - nRange[1]
    dRange <- range(bgr[3,])
    dRange <- c(min(c(0, dRange[1])), dRange[2])
    dDelta <- dRange[2] - dRange[1]
    max <- 2 * max(c(nDelta, dDelta))
    bgr[2,] <- bgr[2,] / max
    bgr[3,] <- bgr[3,] / max
    if(plot){
        plot(grid, bgr[4,], ylim = yRange, type = "l", 
            main = if(is.null(main)) node else main, xlab = xlab, ylab = ylab, col = col[1], ...)
        lines(grid, bgr[2,], col = col[2], ...)
        lines(grid, bgr[3,], col = col[3], ...)
    }
    bgr <- data.frame(t(bgr))
    names(bgr) <- c("Iteration", "pooledChain80pct", "withinChain80pct", "bgrRatio")
    bgr$Iteration <- as.integer(bgr$Iteration)
    if(plot) invisible(bgr)
    else return(bgr)
}
