## Makefile
##
## 
.PHONY: check-env build-libzmq build-test-bins test-release test-latency test-thoughput clean 

GEN_LIBZMQ_TESTS_DIR=tests/release/
GEN_LIBZMQ_TESTS_FILE=$(GEN_LIBZMQ_TESTS_DIR)/api_testsuite.txt

## required for Chart library, also requires svg.charts to be installed
## >  sudo pip install sv.charts
PYTHONPATH=$(PWD)/tools

all: 
	echo "Usage: make clean|test-release|build-libzmq|build-test-bins|gen-api-testsuite"

check-env:
ifndef LIBZMQ_ROOT
	$(error Environment variable LIBZMQ_ROOT is undefined)
endif


## Builds the libzmq and installs to build/ directory or location
## specified by PREFIX
build-libzmq:
	make -f BuildLibZMQ.mk build-libzmq


build-test-bins: check-env
	echo "not implemented yet"


gen-api-testsuite:  check-env templates/api_testsuite_footer.txt templates/api_testsuite_header.txt
	mkdir -p $(GEN_LIBZMQ_TESTS_DIR)
	rm -f $(GEN_LIBZMQ_TESTS_FILE)
	cat templates/api_testsuite_header.txt >>  $(GEN_LIBZMQ_TESTS_FILE)
	find  ${LIBZMQ_ROOT}/tests -maxdepth 1 -executable -a -type f -printf '%f  $${LIBZMQ_ROOT}/tests/%f\n'  >>  $(GEN_LIBZMQ_TESTS_FILE)
	cat templates/api_testsuite_footer.txt>>  $(GEN_LIBZMQ_TESTS_FILE)


test-release:  check-env
	pybot  --include release tests/


test-latency:  check-env
	pybot  --include latency tests/


test-throughput:  check-env
	pybot  --include throughput tests/



clean:
	rm -rf  *.html *.xml 
	find . -name "*~" -exec rm -f {} \;  
