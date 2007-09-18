"bugsInits" <-
function (inits, numChains = 1, fileName, digits = 5){
    if(missing(fileName))
        fileName <- file.path(getwd(), paste("inits", 1:numChains, ".txt", sep = ""))
    if(length(fileName) != numChains)
        stop("numChains = ", numChains, " filenames must be specified")
    if(!is.null(inits)){
      for (i in 1:numChains){
        if (is.function(inits))
          if (is.R())
            write.datafile(lapply(inits(), formatC, digits = digits, format = "E"), fileName[i])
          else
            writeDatafileS4(inits(), towhere = fileName[i])
        else
          if (is.R())
            write.datafile(lapply(inits[[i]], formatC, digits = digits, format = "E"), fileName[i])
          else
            writeDatafileS4(inits[[i]], towhere = fileName[i])
      }
  }
  invisible(fileName)
}
