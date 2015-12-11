RST_FILES = $(wildcard *.rst)
HTML_FILES = $(patsubst %.rst,%.html,$(RST_FILES))

all : $(HTML_FILES)

$(HTML_FILES): %.html: %.rst Makefile
	rst2html.py $< $@

README.html : Examples/CheatSheet.rst

Examples/CheatSheet.rst : Examples/CheatSheet.py
	python $< >$@
