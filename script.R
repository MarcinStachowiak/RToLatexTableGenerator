#' ---
#' title: "RToLatexTABLEGENERATOR"
#' author: "Marcin STachowiak"
#' date: "March 24, 2018"
#' ---
#' 
options(warn = -1)
library(xtable)
source('bib2df.r')
source('bib2df_read.r')
source('bib2df_gather.r')
source('bib2df_tidy.r')

a = bib2df('test.bib')
options(xtable.floating = FALSE)
options(xtable.timestamp = "")

bib_file = 'test.bib'
bib = bib2df(bib_file)

author_label = 'Author'
title_label = 'Title'
year_label = 'Year'
status_label = 'Included/Excluded'
summary_label = 'Summary'
rq1_label = 'Relevant to RQ1'
rq2_label = 'Relevant to RQ2'
rq3_label = 'Relevant to RQ3'
rq4_label = 'Relevant to RQ4'
method_label = 'Method name'
quality_label = 'Quality Assessment result'
future_works_label = 'Improvement ideas'
url_label = 'URL'
language_label = 'Implemented for language'
deep_learning_architecture_label = 'Deep learning architecture'
current_state_label = 'Development state'
se_area_label = "SE area"
rup_discipline_label = "RUP discipline"

build_data_frame <- function(b) {
  column_names = c(
    author_label,
    title_label,
    year_label,
    url_label,
    se_area_label,
    rup_discipline_label,
    status_label,
    rq1_label,
    rq2_label,
    rq3_label,
    rq4_label,
    method_label,
    deep_learning_architecture_label,
    quality_label,
    future_works_label,
    current_state_label,
    language_label,
    summary_label
  )
  column = c(
    toString(unlist(b$AUTHOR)),
    b$TITLE,
    b$YEAR,
    b$URL,
    b$SE_AREA,
    b$RUP_DISCIPLINE,
    b$STATUS,
    b$RQ1,
    b$RQ2,
    b$RQ3,
    b$RQ4,
    b$METHOD,
    b$DEEP_LEARNING_ARCHITECTURE,
    b$QUALITY,
    b$FUTURE_WORKS,
    b$CURRENT_STATE,
    b$LANGUAGE,
    b$SUMMARY
  )
  b.data <- data.frame(column)
  rownames(b.data) <- column_names
  return(b.data)
}

convert_bibtex_to_dataframes <- function(bibtex) {
  bib.list = list()
  for (i in 1:nrow(bibtex)) {
    bib.data <- build_data_frame(bibtex[i,])
    bib.list[[i]] <- bib.data
  }
  return(bib.list)
}

italic <- function(x) {
  paste0('\\textit{', x, '}')
}

draw_tables_for_search_result <- function(bib.list) {
  row_names = c(
    author_label,
    title_label,
    year_label,
    url_label,
    rq1_label,
    rq2_label,
    rq3_label,
    rq4_label,
    status_label
  )
  for (df in bib.list) {
    df.filtered = data.frame(df[row_names,], row.names = row_names)
    tab <-
      xtable(df.filtered,
             caption = paste0('Search result for "', df[title_label,], '" (', df[author_label,], ')'))
    align(tab) <- "|R{3cm}|L{8,5cm}|"
    hlines <- c(0, nrow(df.filtered))
    print(
      tab,
      floating = TRUE,
      include.rownames = TRUE,
      include.colnames = FALSE,
      sanitize.rownames.function = italic,
      hline.after = hlines
    )
  }
}

draw_tables_for_data_extraction <- function(bib.list) {
  row_names = c(
    se_area_label,
    rup_discipline_label,
    author_label,
    title_label,
    year_label,
    url_label,
    method_label,
    deep_learning_architecture_label,
    summary_label,
    current_state_label,
    language_label,
    future_works_label,
    quality_label
  )
  for (df in bib.list) {
    if (isTRUE(df[status_label, 1] == 'Included')) {
      df.filtered = data.frame(df[row_names,], row.names = row_names)
      tab <-
        xtable(df.filtered,
               caption = paste0('Data extraction form for "', df[title_label,], '" (', df[author_label,], ')'))
      align(tab) <- "|R{4cm}|L{7,5cm}|"
      hlines <- c(0, 2, 6, 8, 9, 12, nrow(df.filtered))
      print(
        tab,
        floating = TRUE,
        include.rownames = TRUE,
        include.colnames = FALSE,
        sanitize.rownames.function = italic,
        hline.after = hlines
      )
    }
  }
}


bib.list <- convert_bibtex_to_dataframes(bib)
draw_tables_for_search_result(bib.list)
draw_tables_for_data_extraction(bib.list)
