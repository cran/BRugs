".onLoad" <- function(lib, pkg){
    ## Don't know whether we have to do this before useDynLib()???
    Sys.putenv("LD_ASSUME_KERNEL"="2.4.1")
    ## sets path / file variables and initializes subsystems
    root <- file.path(system.file("OpenBUGS", package="BRugs"))
    ## we do have a NAMESPACE now: library.dynam("BRugs", pkg, lib)
    len <- nchar(root)
    .C("SetRootDir", as.character(root), as.integer(len), PACKAGE="BRugs")
    command <- "INIT()"
    tempDir <- gsub("\\\\", "/", tempdir())
    .C("SetTempDir", as.character(tempDir), nchar(tempDir), PACKAGE="BRugs")
    .C("EmbedCommand", command, nchar(command), integer(1), PACKAGE="BRugs")
}

".onAttach" <- function(lib, pkg){
    cat("Welcome to BRugs running on OpenBUGS version 2.1.0", "\n")
}

".onUnload" <- function(libpath){
    library.dynam.unload("BRugs", libpath)
}
