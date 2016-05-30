NAME=advanced_latex
all: ${NAME}.pdf

${NAME}.tex: ${NAME}.md Makefile
	pandoc -s $< -t beamer --slide-level=2 -o $@

${NAME}.pdf: ${NAME}.tex 3dplot.tex Makefile
	latexmk -xelatex -pdf -shell-escape -halt-on-error $<

clean:
	rm -f *.pdfsync
	rm -rf *~ *.tmp
	rm -f *.{nav,out,snm,aux,log,toc,vrb,fls,fdb_latexmk}

.PHONY:
	clean all
