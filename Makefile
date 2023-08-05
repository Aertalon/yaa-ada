.PHONY: build clean prove tests coverage

build:
	cd yaa && alr build --validation

clean:
	cd yaa && alr clean
	cd tests && alr clean
	rm -rf yaa/build tests/build tests/build/cov tests/TEST-*.xml

prove:
	cd yaa && alr gnatprove -j0 --level=4

tests:
	cd tests && alr build
	cd tests && alr run -s

coverage:
	mkdir -p tests/build/cov
	lcov -q -c -d yaa/build/obj -d tests/build/obj -o tests/build/cov/unit.info
	lcov -q -r tests/build/cov/unit.info */adainclude/* -o tests/build/cov/unit.info
	lcov -q -r tests/build/cov/unit.info */tests/* -o tests/build/cov/unit.info
	genhtml -q --ignore-errors source -o tests/build/cov/html tests/build/cov/unit.info
	lcov -l tests/build/cov/unit.info
