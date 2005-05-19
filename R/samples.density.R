"samplesDensity" <-
function(node, beg = samplesGetBeg(), end = samplesGetEnd(), 
firstChain = samplesGetFirstChain(), lastChain = samplesGetLastChain(), 
thin = samplesGetThin(), mfrow = c(3, 2), ask = NULL, ann = TRUE, ...)
# Plot posterior density                            
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
    beg <- max(beg, modelAdaptivePhase())
    samplesSetBeg(beg)
    samplesSetEnd(end)
    samplesSetFirstChain(firstChain)
    samplesSetLastChain(lastChain)
    thin <- max(c(thin, 1))
    samplesSetThin(thin)
    mons <- samplesMonitors(node)
    par(mfrow = mfrow, ask = ask, ann = ann)
    junk <- sapply(mons, plotDensity, ...)
}
