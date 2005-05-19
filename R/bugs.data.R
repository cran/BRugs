"bugsData" <-
function(data, fileName = file.path(getwd(), "data.txt"), digits = 5){
  if(is.numeric(unlist(data)))
    write.datafile(lapply(data, formatC, digits = digits, format = "E"), fileName)
  else {
    data.list <- lapply(as.list(data), get, pos = parent.frame(2))
    names(data.list) <- as.list(data)
    write.datafile(lapply(data.list, formatC, digits = digits, format = "E"), fileName)
  }
  invisible(fileName)
}
