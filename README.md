# RToLatexTableGenerator

# Preconditions
1. Put all files from this repository in your sharelatex account in the Rscripts folder.
2. Rename an extension of the protocol file from .tex to .Rtex
3. Add the following commands to the top of your document:
```
\usepackage{array}
\usepackage{url}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
```

# Generate Search Result Tables
4. Add the following lines to the place where you want to generate the tables:
```
<<echo=F,results="asis",cache=FALSE>>=
source('Rscripts/table_generator.r')
bib.list <- convert_bibtex_to_dataframes(bib)
draw_tables_for_search_result(bib.list)
@
```
# Generate Data Extraction Tables
5. Add the following lines to the place where you want to generate the tables:
```
<<echo=F,results="asis",cache=FALSE>>=
source('rscripts/table_generator.r')
bib.list <- convert_bibtex_to_dataframes(bib)
draw_tables_for_data_extraction(bib.list)
@
```
# You can edit the table contents directly in the .bib file
Below is an exemplary bibtex file containing information on the basis of which the tables will be generated:
```
@ARTICLE{abc,
  author={M. Choetkiertikul and H. K. Dam and T. Tran and A. Ghose and J. Grundy}, 
  title = {the article title},
  journal = {the journal},
  year = {2012},
  volume = {1},
  pages = {1--2},
  number = {1},
  month = {1},
  url ={www.google.pl},
  doi = {1234/5678},
  se_area= {Testing},
  rup_discipline={discipline},
  rq1 = Yes,
  rq2 = Yes,
  rq3 = Yes,
  rq4 = Yes,
  status = {Included},
  method = {method name},
  deep_learning_architecture={Deep Learning Method},
  summary= {THis articles},
  language = {Java},
  future_works = {Nothing},
  current_state={evaluated},
  quality = {5,42}
}
```
