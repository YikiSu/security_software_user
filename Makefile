# sercurity user 
# author: Yiki Su
# date: 2021-01-04

all: script/eda.md

# download data
data/22100010.csv: script/download_data.R
	Rscript script/download_data.R --url="https://www150.statcan.gc.ca/n1/tbl/csv/22100010-eng.zip" --out_path="data"
	
# clean data 
result/data.feather: data/22100010.csv
	Rscript script/clean_data.R --input="data/22100010.csv" --out_path="result" 

# exploratory data analysis 
result/2010plot.png result/2012plot.png: result/data.feather
	Rscript script/eda.R --input="result/data.feather" --out_path="result"

# render the report
script/eda.md : script/eda.Rmd result/data.feather doc/software_testing_refs.bib result/2012plot.png result/2010plot.png
	Rscript -e "rmarkdown::render('script/eda.Rmd', output_format = 'github_document')"
	
clean: 
	rm -rf data
	rm -rf result
	rm -rf script/eda.md
			
