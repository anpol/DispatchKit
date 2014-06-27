HTML = \
	CONTRIBUTING.html \
	LICENSE.html \
	RATIONALE.html \
	README.html 

all : $(HTML)

$(HTML): %.html: %.rst Makefile
	rst2html.py $< $@

README.html : Examples/CheatSheet.rst

Examples/CheatSheet.rst : Examples/CheatSheet.py
	python $< >$@
