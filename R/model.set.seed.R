"modelSetSeed" <- 
function(newSeed)
#   Set the seed of random number generator
{
    if(!is.numeric(newSeed))
        stop("newSeed ", "must be numeric")
    newSeed <- as.integer(newSeed)
    for(i in seq(along=newSeed)){
        command <- paste("BugsEmbed.index :=", i, "; BugsEmbed.new :=", newSeed[i], 
            ";BugsEmbed.SetRNGuard; BugsEmbed.SetRNState")
        res <- .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")[[3]]
    }
    if(!res) cat("Seed successfully set\n")
    else stop("Setting seed returned with an error.")
}    
