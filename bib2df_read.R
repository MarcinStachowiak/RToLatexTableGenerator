#' @importFrom stringr str_replace_all
library(stringr,verbose=FALSE,warn.conflicts = FALSE)
bib2df_read <- function(file) {
  bib <- readLines(file)
  bib <- str_replace_all(bib, "[^[:graph:]]", " ")
  return(bib)
}
