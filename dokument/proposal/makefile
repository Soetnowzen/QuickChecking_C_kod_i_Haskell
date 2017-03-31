all:
	xelatex main.tex

fix-ref:
	xelatex main.tex
	bibtex main
	xelatex main.tex
	xelatex main.tex

clean:
	rm -rf *.aux
	rm -rf *.log
	rm -rf *.out
	rm -rf *.bbl
	rm -rf *.blg
	rm -rf .**.un~
