# install.packages("exams", repos="http://R-Forge.R-project.org")
# devtools::install_github("bdemeshev/rexamsconverter")

library(tidyverse)
# library(rio)
library(tools)

library(exams)
library(rexamsconverter)


filenames = list.files(c('../base/2022-07-30_dvfu-games/'),
                       pattern = "*.Rmd",
                       full.names = TRUE, recursive = TRUE)


files_df = tibble(filename = filenames)
files_df = mutate(files_df, short = basename(filename),
                  noext = file_path_sans_ext(short))


glimpse(files_df)

files_df = files_df[1:20, ]

options(texi2dvi = Sys.which('xelatex'), exams_tex = 'tools') 
# 'tools' means 'dont use tinytex', and then select engine!

res = exams2pdf_source(files_df$filename, date = "2022-07-01",
                       n_vars = 3, title = "2022-07-01-dvfu", institution = "dvfu", 
                       nops = FALSE, shuffle = TRUE,
                       add_seed = 403,
                       template = "../templates/2022-07-01-dvfu-template.tex",
                       output_dir = paste0("../snapshots/2022-07-01-dvfu_games/"))



