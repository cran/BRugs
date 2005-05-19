buffer <- function(){
    buffer <- file.path(tempdir(), "buffer.txt")
    cat(readLines(buffer), "\n")
}
