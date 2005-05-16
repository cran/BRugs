help.BRugs <- function(browser = getOption("browser"))
{
    # stolen from help.start()
    a <- system.file("OpenBUGS", "docu", "BRugs Manual.html", package="BRugs")
    if (!file.exists(a)) 
        stop("I can't find the html help")
    a <- chartr("/", "\\", a)
    cat("If nothing happens, you should open `", a, "' yourself\n")
    browseURL(a, browser = browser)
    invisible("")
}

help.WinBUGS <- function(browser = getOption("browser"))
{
    # stolen from help.start()
    a <- system.file("OpenBUGS", "docu", "WinBUGS Manual.html", package="BRugs")
    if (!file.exists(a)) 
        stop("I can't find the html help")
    a <- chartr("/", "\\", a)
    cat("If nothing happens, you should open `", a, "' yourself\n")
    browseURL(a, browser = browser)
    invisible("")
}
