"dicStats" <-
function()
#   Calculate dic statistics
{
    command <- "DevianceEmbed.SetVariable('*');DevianceEmbed.StatsGuard;DevianceEmbed.Stats"
    .C("CmdInterpreter", command, nchar(command), integer(1), PACKAGE="BRugs")
    buffer <- file.path(tempdir(), "buffer.txt")
    rlb <- readLines(buffer)
    len <- length(rlb)
    if (len > 1) {
        # Remove the extra lines in the buffer that contain the minimum deviance information
        minDeviancePos <- regexpr(pattern = "Minimum deviance", text = rlb)
        lineToRemove <- which(minDeviancePos != -1)
        rlb <- rlb [1:(lineToRemove-1)]
        writeLines(rlb, buffer)
        read.table(buffer)
    } else {
        message(rlb)
    }
}
