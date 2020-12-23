# author: Zhanyi Su
# date: 2020-12-22

"This script takes in a feather file from the result folder and generate plots. At the end, save the plot data in a png file in the result folder.

Usage: eda.R --input=<input> --out_path=<out_path>

Options:
----input=<input>        The csv file to read in
--out_path=<out_path>    Path of where to locally save the feather file
" -> doc



opt <- docopt(doc)

main <- function(input, out_path) {
  
  
}


main(opt$input, opt$out_path)
