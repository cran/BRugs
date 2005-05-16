buildMCMC <- function(node, beg = samplesGetBeg(), end = samplesGetEnd(),
    firstChain = samplesGetFirstChain(), lastChain = samplesGetLastChain(), 
    thin = samplesGetThin()){

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
    
    subBuildMCMC <- function(node){
        sM <- samplesMonitors(node)
        if(length(sM) > 1 || sM != node)
            stop("node must be a scalar variable from the model, for arrays use samplesAutoC")
        nodeName <- sQuote(node)
        command <- paste("SamplesEmbed.SetVariable(", nodeName, ")")
        .C("CmdInterpreter", command, nchar(command), integer(1), 
            PACKAGE = "BRugs")
        command <- "SamplesEmbed.SampleSize"
        sampleSize <- as.integer(.C("Integer", command, nchar(command), 
            integer(1), integer(1), PACKAGE = "BRugs")[[3]])
        command <- "SamplesEmbed.Sample"
        sample <- .C("RealArray", command, nchar(command), real(sampleSize), 
            sampleSize, integer(1), PACKAGE = "BRugs")[[3]]
        numChains <- samplesGetLastChain() - samplesGetFirstChain() + 1
        matrix(sample, ncol = numChains)
    }

    nodeName <- sQuote(mons[1])
    command <- paste("SamplesEmbed.SetVariable(", nodeName, ")")
    .C("CmdInterpreter", command, nchar(command), integer(1), 
       PACKAGE = "BRugs")
    command <- "SamplesEmbed.SampleSize"
    sampleSize <- as.integer(.C("Integer", command, nchar(command), 
        integer(1), integer(1), PACKAGE = "BRugs")[[3]])
    end <- min(c(modelIteration(), samplesGetEnd()))
    thin <- samplesGetThin()
    numChains <- samplesGetLastChain() - samplesGetFirstChain() + 1
    sampleSize <- sampleSize %/% numChains
    beg <- end - (sampleSize - 1) * thin
    beg <- beg %/% thin
    end <- end %/% thin

    samples <- lapply(mons, subBuildMCMC)
    samplesChain <- vector(mode="list", length=numChains)

    for(i in 1:numChains){
        temp <- sapply(samples, function(x) x[,i])
##### If we want to special-case 1D-mcmc objects:
#        if(ncol(temp) == 1){
#            dim(temp) <- NULL
#            samplesChain[[i]] <- temp
#        }
#        else{
       samplesChain[[i]] <- temp
       colnames(samplesChain[[i]]) <- mons
#        }
    }

    require(coda)
    mcmcobj <- lapply(samplesChain, mcmc, start = beg, end = end, thin = thin)
    class(mcmcobj) <- "mcmc.list"
    mcmcobj
}




 
