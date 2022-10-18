# install.packages("exams", repos="http://R-Forge.R-project.org")
# devtools::install_github("bdemeshev/rexamsconverter")

library(tidyverse)
# library(rio)
library(tools)

library(exams)
library(rexamsconverter)


filenames = list.files(c('../base/2022-07-01_dvfu-games/'),
                       pattern = "*.Rmd",
                       full.names = TRUE, recursive = TRUE)
set.seed(333)
filenames = sample(filenames, replace = FALSE, size = 15)

filenames2 = list.files(c('../base/2022-10-11-dvfu-games-retake/'),
                        pattern = "*.Rmd",
                        full.names = TRUE, recursive = TRUE)
filenames = c(filenames, filenames2)

files_df = tibble(filename = filenames)
files_df = mutate(files_df, short = basename(filename),
                  noext = file_path_sans_ext(short))


glimpse(files_df)


options(texi2dvi = Sys.which('xelatex'), exams_tex = 'tools') 
# 'tools' means 'dont use tinytex', and then select engine!

res = exams2pdf_source(files_df$filename, date = "2022-10-12",
                       n_vars = 1, title = "2022-10-12-dvfu", institution = "dvfu", 
                       nops = FALSE, shuffle = TRUE,
                       add_seed = 403,
                       template = "../templates/2022-10-12-dvfu-template.tex",
                       output_dir = paste0("../snapshots/2022-10-12-dvfu_games/"))



