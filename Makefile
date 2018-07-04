all:
	Rscript -e "rmarkdown::render('index.Rmd', output_format = 'all', quiet = TRUE)"

serve:
	browser-sync start --server --no-ui --port 3000 --no-open --files *.html
