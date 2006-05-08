"modelSaveState" <- function(stem)
{
# Saves the sate of each chain in OpenBUGS model
  command <- paste("BugsEmbed.UpdateGuard",
  ";BugsEmbed.WriteChains(", sQuote(stem), ")")
  .C("CmdInterpreter", as.character(command), nchar(command), integer(1), PACKAGE="BRugs")
  if(getOption("BRugsVerbose")) 
      buffer()
}
