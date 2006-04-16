".onLoad" <- function(lib, pkg){
    ## Don't know whether we have to do this before useDynLib()???
    #Sys.putenv("LD_ASSUME_KERNEL"="2.4.1")
    ## sets path / file variables and initializes subsystems
    root <- file.path(system.file("OpenBUGS", package=pkg))
    ## we do have a NAMESPACE now: library.dynam("BRugs", pkg, lib)
    len <- nchar(root)
    tempDir <- gsub("\\\\", "/", tempdir())
    .C("Initialize", as.character(root), as.character(tempDir), 
        as.integer(len), nchar(tempDir), PACKAGE="BRugs")
}

".onAttach" <- function(lib, pkg){
    cat("Welcome to BRugs running on OpenBUGS version 2.2.0 beta", "\n")
}

".onUnload" <- function(libpath){
    library.dynam.unload("BRugs", libpath)
}
