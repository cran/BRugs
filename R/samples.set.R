"samplesSet" <-
function(node)
#   Set a sample monitor
{
    nodeName <- sQuote(node)
    for(i in seq(along=nodeName)){
        sM <- paste(samplesMonitors(node[i]), collapse = " ")
        if(sM == "model must be initialized before monitors used")
            stop("model must be initialized before monitors used")
        if(sM == "inference can not be made when sampler is in adaptive phase")
            alreadySet <- FALSE
        else 
            alreadySet <- !length(grep("no monitor set", sM))
        eval(alreadySet)
        command <- paste("SamplesEmbed.SetVariable(", nodeName[i], 
                                ");SamplesEmbed.SetGuard;SamplesEmbed.Set")
        .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
        buffer <- file.path(tempdir(), "buffer.txt")
        rlb <- readLines(buffer)
        if(rlb == "") 
            message("either model has not been updated or variable ", nodeName[i], " already set")
        else{
            if(getOption("BRugsVerbose")){
                if(alreadySet)
                    message("monitor for variable ", nodeName[i], " already set")
                else message(rlb, " for variable ", nodeName[i])
            }
        }
    }
    invisible()
}
