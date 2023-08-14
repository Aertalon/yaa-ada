.PHONY: build clean prove tests coverage

build:
	cd yaa && alr build --validation
	cd ..
	cd tests && alr build

clean:
	cd yaa && alr clean
	cd tests && alr clean && rm -rf build

prove:
	cd yaa && alr gnatprove -j0 --level=4

tests:
	cd tests && alr build
	cd tests && alr run -s

coverage:
	# Instrument the project code for coverage analysis.
	cd tests && alr gnatcov instrument --level=stmt --dump-trigger=atexit --projects ../yaa.gpr
	# Build testsuite with instrumented code.
	cd tests && alr build -- --src-subdirs=gnatcov-instr --implicit-with=gnatcov_rts_full
	# Run the instrumented testsuite. This will produce at least one `.srctrace` file for the coverage analysis.
	cd tests && alr exec ./build/bin/test_bindings
	# Move *.srctrace to build/traces
	cd tests && mkdir build/traces/ && mv *.srctrace build/traces/
	# Run the GNATcov code coverage analysis on the trace files.
	cd tests && alr gnatcov coverage --annotate=html --output-dir build/gnatcov_out_html --level=stmt --projects ../yaa.gpr build/traces/*.srctrace
	cd tests && alr gnatcov coverage --annotate=xcov --output-dir build/gnatcov_out_xcov --level=stmt --projects ../yaa.gpr build/traces/*.srctrace


