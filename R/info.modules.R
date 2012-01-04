"infoModules" <-
    function()
                                        #   List loaded OpenBUGS components
{
    command <- "BugsEmbed.Modules"
    .CmdInterpreter(command)
    buffer <- file.path(tempdir(), "buffer.txt")
    result <- read.fwf(buffer, c(50, 12, 12, 12, 12, 10), skip = 1, as.is=TRUE)
    for(i in c(1,4,5,6))
        result[,i] <- gsub(" ", "", result[,i])
    names(result) <- c("Module", "Clients", "Version", "Maintainer", "Compiled", "Loaded")
    return(result)    
}
