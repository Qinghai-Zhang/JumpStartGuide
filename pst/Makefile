allEps : test.eps

clean :
	rm -rf *.aux *.log *.dvi *~

purge :
	rm -rf *.aux *.log *.dvi *~ *.eps *.pdf

%.eps : %.dvi
	dvips $< -E -o $@

%.dvi : %.tex
	latex $<
