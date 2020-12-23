# author: Zhanyi Su
# date: 2020-12-22

"This script takes in a csv file from the data folder and process the data wrangling. At the end, save the processed data in a feather file in the result folder.

Usage: clean_data.R --input=<input> --out_path=<out_path>

Options:
----input=<input>        The csv file to read in
--out_path=<out_path>    Path of where to locally save the feather file
" -> doc

library(docopt)
library(tidyverse)
library(feather)
library(janitor)

opt <- docopt(doc)

main <- function(input, out_path) {
  
  # To read in the raw data csv file 
  raw_data <- read_csv(input)
  
  # data wrangling
  data <- clean_names(raw_data)
  
  # write processed data to a feather file
  try({
    dir.create(out_path)
  })
  write_feather(data, paste0(out_path, "/data.feather"))
  
  
}


main(opt$input, opt$out_path)
