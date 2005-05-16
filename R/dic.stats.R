"dicStats" <-
function()
#   Calculate dic statistics
{
    command <- "DevianceEmbed.StatsGuard;DevianceEmbed.Stats"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    rlb <- readLines(buffer)
    len <- length(rlb)
    if (len > 1) 
        read.table(buffer)
    else
        cat(rlb, "\n")
}
