NAME=advanced_latex
all: ${NAME}.pdf

${NAME}.pdf: ${NAME}.md Makefile
	pandoc $< -t beamer --latex-engine=xelatex --slide-level=2 -o $@ --verbose

clean:
	rm -f *.pdfsync
	rm -rf *~ *.tmp

.PHONY:
	clean all
