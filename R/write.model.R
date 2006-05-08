writeModel <- function(model, con = "model.txt")
{
  model.text <- attr(model, "source")
  model.text <- sub("^\\s*function\\s*\\(\\s*\\)", "model", model.text)
  model.text <- sub("%_%", "", model.text)
  writeLines(model.text, con = con)
}
