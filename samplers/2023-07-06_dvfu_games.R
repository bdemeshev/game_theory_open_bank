# install.packages("exams", repos="http://R-Forge.R-project.org")
# devtools::install_github("bdemeshev/rexamsconverter")

library(tidyverse)
# library(rio)
library(tools)

library(exams)
library(rexamsconverter)


old_filenames = list.files(c('../base/2022-07-01_dvfu-games/',
                         '../base/2022-10-11-dvfu-games-retake/'),
                       pattern = "*.Rmd",
                       full.names = TRUE, recursive = TRUE)

old_filenames = sample(old_filenames, 18)


new_filenames = list.files('../base/2023-07-06-dvfu-games/',
                           pattern = "*.Rmd",
                           full.names = TRUE, recursive = TRUE)



files_df = tibble(filename = c(old_filenames, new_filenames))
files_df = mutate(files_df, short = basename(filename),
                  noext = file_path_sans_ext(short))


glimpse(files_df)

# files_df = files_df[1:20, ]

options(texi2dvi = Sys.which('xelatex'), exams_tex = 'tools') 
# 'tools' means 'dont use tinytex', and then select engine!

res = exams2pdf_source(files_df$filename, date = "2023-07-06",
                       n_vars = 2, title = "2022-07-06-dvfu", institution = "dvfu", 
                       nops = FALSE, shuffle = TRUE,
                       add_seed = 421,
                       template = "../templates/2023-07-06-dvfu-template.tex",
                       output_dir = paste0("../snapshots/2023-07-06-dvfu_games/"))



