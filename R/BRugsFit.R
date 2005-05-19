BRugsFit <-
function(modelFile, data, inits, numChains = 3, parametersToSave,
    nBurnin = 1000, nIter = 1000, nThin = 1,
    DIC = TRUE, working.directory = NULL, digits = 5){

  if(!is.null(working.directory)){
      savedWD <- getwd()
      setwd(working.directory)
      on.exit(setwd(savedWD))
  }
  if(!file.exists(modelFile)) stop(modelFile, " does not exist")
  if(file.info(modelFile)$isdir) stop(modelFile, " is a directory, but a file is required")  
  modelCheck(modelFile)
  if(!(is.vector(data) && is.character(data) && all(file.exists(data))))
    data <- bugsData(data, digits = digits)  
  modelData(data)    
  modelCompile(numChains)
  if(missing(inits)){
    modelGenInits()
  }
  else{
    if(is.function(inits) || (is.character(inits) && !any(file.exists(inits))))
        inits <- bugsInits(inits = inits, numChains = numChains, digits = digits)
    print(inits)
    modelInits(inits)
  }
  samplesSetThin(nThin)
  modelUpdate(nBurnin)
  if(DIC){
    dicSet()
    on.exit(dicClear(), add = TRUE)
  }
  samplesSet(parametersToSave)
  modelUpdate(nIter)
  sims <- samplesStats("*")
#  class(sims) <- "BRugsFit"
  return(list(Stats = sims, DIC = if(DIC) dicStats()))
}
