SOURCES=$(wildcard *.R)
OBJECTS=$(SOURCES:.R=.out)
all: $(OBJECTS)
%.out: %.R
	Rscript $< > $@
clean:
	rm -rf *~ *.out *.pdf *.rda

