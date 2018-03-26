#' @importFrom stringr str_replace_all
library(stringr,verbose=FALSE)
bib2df_read <- function(file) {
  bib <- readLines(file)
  bib <- str_replace_all(bib, "[^[:graph:]]", " ")
  return(bib)
}
