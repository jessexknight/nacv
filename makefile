all:
	make ins ;\
	make doc ;\
	make tests ;\
	make zip ;\

ins:
	cd nacv ;\
	rm nacv.cls ;\
	pdflatex nacv.ins

doc:
	cd nacv ;\
	pdflatex nacv.dtx

tests:
	for test in test/* ; do \
		cp nacv/nacv.cls $$test ;\
		cd $$test ;\
		pdflatex main && pdflatex main && biber main && pdflatex main ;\
		rm nacv.cls ;\
		cd ../../ ;\
	done

debug:
	cp nacv/nacv.cls test/.debug/ ;\
	cd test/.debug ;\
	pdflatex main && pdflatex main && biber main && pdflatex main ;\
	rm nacv.cls ;\

zip:
	zip ctan/nacv.zip \
		nacv/nacv.dtx \
		nacv/nacv.ins \
		nacv/nacv.pdf \
		nacv/README
