#include LaTeX.mk

BIBTEX  := bibtex
DVIPS   := dvips
LATEX   := pdflatex
PSPDF   := ps2pdf
RM      := rm -rf

default : Guide.pdf

%.pdf : %.tex bib eps png pst sec
	$(MAKE) --directory=pst
	$(LATEX) $<
	$(BIBTEX) $*
	$(LATEX) $<
	$(LATEX) $<

# Use the following if your latex command is LaTeX instead of pdf latex.
#%.ps  : %.dvi
#	dvips $< -t letter -o $@
#%.pdf : %.ps
#	$(PSPDF) $< $@

# use this target to clean up intermediate file yet retain the pdf doc.
clean :
	$(MAKE) --directory=pst clean
	$(RM) *.aux *.blg *.bbl *.dvi *.gz *.log *.toc *~ */*~

# use this target to purge the directory
#  so that the folder contains only the bare necessities.
purge : 
	$(MAKE) --directory=pst purge
	$(RM) *.aux *.blg *.bbl *.dvi *.gz *.log *.toc *~ */*~ eps/*.pdf *.pdf

# use this target to generate a gzipped-tar tall
#  for redistributing the source files.
%.tar.gz : %.tex bib eps png pst sec
	mkdir $* $*/bib $*/eps $*/png $*/pst $*/sec
	cp $*.tex *.cls Makefile $*/
	cp bib/*.bib $*/bib/
	cp eps/*.eps $*/eps/
	cp png/*.png $*/png/
	cp pst/*.eps pst/Makefile $*/pst/
	cp sec/*.tex $*/sec/
	tar cvf $*.tar $*
	gzip $*.tar
	$(RM) $* $*.tar
