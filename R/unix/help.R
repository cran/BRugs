help.BRugs <- function(browser = getOption("browser"))
{
    # stolen from help.start()
    if(is.null(browser))
    stop("Invalid browser name, check options(\"browser\").")
    writeLines(strwrap(paste("If", browser, "is already running,",
                             "it is *not* restarted, and you must",
                             "switch to its window."),
                       exdent = 4))
    writeLines("Otherwise, be patient ...")
    browseURL(system.file("OpenBUGS", "docu", "BRugs Manual.html", package="BRugs"))
    invisible("")
}

help.WinBUGS <- function(browser = getOption("browser"))
{
    # stolen from help.start()
    if(is.null(browser))
    stop("Invalid browser name, check options(\"browser\").")
    writeLines(strwrap(paste("If", browser, "is already running,",
                             "it is *not* restarted, and you must",
                             "switch to its window."),
                       exdent = 4))
    writeLines("Otherwise, be patient ...")
    browseURL(system.file("OpenBUGS", "docu", "WinBUGS Manual.html", package="BRugs"))
    invisible("")
}
