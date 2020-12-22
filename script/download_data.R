# author: Zhanyi Su
# date: 2020-12-21

"This script downloads a zip file from the given URL and unzip the file. Save the unzipped file into a local file called data.

Usage: download_data.R --url=<url> --out_path=<out_path>

Options:
----url=<url>            ULR to download the zip file
--out_path=<out_path>    Path of where to locally save the file
" -> doc

library(docopt)

opt <- docopt(doc)

main <- function(url, out_path) {
  
  # To download the zip file from the URL
  download.file(url, destfile = "zip")
  
  # To unzip the zip file to the data folder
  unzip("zip", exdir = out_path)
  
  # To remove the zip file after unzipping 
  file.remove("zip")
}


main(opt$url, opt$out_path)
