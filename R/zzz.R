if (is.R()){

    ".onLoad" <- function(lib, pkg){
        ## sets path / file variables and initializes subsystems
        root <- file.path(system.file("OpenBUGS", package=pkg))
        ## we do have a NAMESPACE now: library.dynam("BRugs", pkg, lib)
        len <- nchar(root)
        tempDir <- gsub("\\\\", "/", tempdir())
        .C("SetRoot", as.character(root), len, PACKAGE="BRugs")
        .C("SetTempDir", as.character(tempDir), nchar(tempDir), PACKAGE="BRugs")
        command <- "BugsMappers.SetDest(2)"
        .C("CmdInterpreter", as.character(command), nchar(command), integer(1), PACKAGE="BRugs")
        if(is.null(getOption("BRugsVerbose")))
            options("BRugsVerbose" = TRUE)
    }
    
    ".onAttach" <- function(lib, pkg){
        message("Welcome to BRugs running on OpenBUGS version 3.0.2")
    }
    
    ".onUnload" <- function(libpath){
        library.dynam.unload("BRugs", libpath)
    }

    ## Overwriting new (from R-2.6.0) sQuote (for typing human readable text) in R within the BRugs Namespace!
    ## we cannot use sQuote that uses fancy quotes!
    sQuote <- function(x) paste("'", x, "'", sep="")
        

} else {  # ends if (is.R())

    ".First.lib" <- function(lib.loc, section)
    {
        dyn.open(system.file("OpenBUGS", "brugs.dll", package="BRugs"))
        ## sets path / file variables and initializes subsystems
        root <- file.path(system.file("OpenBUGS", package="BRugs"))
        len <- nchar(root)
        tempDir <- gsub("\\\\", "/", tempdir())
        .C("SetRoot", as.character(root), len)
        .C("SetTempDir", as.character(tempDir), nchar(tempDir))
        command <- "BugsMappers.SetDest(2)"
        .C("CmdInterpreter", as.character(command), nchar(command), integer(1))
        if(is.null(getOption("BRugsVerbose")))
        options("BRugsVerbose" = TRUE)
        invisible()
    }
    
    .tempDir <- getwd()
    
    tempdir <- function(){ .tempDir }

}  # ends else
