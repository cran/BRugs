library(BRugs)

BRugsFit(data = "ratsdata.txt", inits = "ratsinits.txt", 
    para = c("alpha", "beta"), modelFile = "ratsmodel.txt", 
    numChains = 1, 
    working.directory = system.file("OpenBUGS", "Examples", 
                                    package = "BRugs"))

setwd(system.file("OpenBUGS", "Examples", package="BRugs"))
modelCheck("ratsmodel.txt")
modelData("ratsdata.txt")
modelCompile(numChains=2)
modelInits(rep("ratsinits.txt", 2))
modelUpdate(1000)
samplesSet(c("alpha0", "alpha"))
modelUpdate(1000)
samplesStats("*")
