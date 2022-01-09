all:00.out 01.out 02.out
%.out:%.R
	Rscript $< > $@

