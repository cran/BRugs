"samplesHistory" <-
function(node, beg = samplesGetBeg(), end = samplesGetEnd(),
firstChain = samplesGetFirstChain(), lastChain = samplesGetLastChain(), 
thin = samplesGetThin(), plot = TRUE, mfrow = c(3, 1), ask = NULL, ann = TRUE, ...)
#   Plot history                    
{
    if(is.null(ask))
        ask <- !((dev.cur() > 1) && !dev.interactive())
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
    mons <- samplesMonitors(node)
    par(mfrow = mfrow, ask = ask, ann = ann)
    result <- lapply(mons, plotHistory, plot = plot, ...)
    names(result) <- mons
    if(plot) invisible(result)
    else     return(result)

}
