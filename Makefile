
GEN_LIBZMQ_TESTS_DIR=libzmq_tests
GEN_LIBZMQ_TESTS_FILE=$(GEN_LIBZMQ_TESTS_DIR)/libzmq_tests.txt

$(GEN_LIBZMQ_TESTS_FILE):  templates/ts_header.txt  templates/ts_footer.txt
	mkdir -p $(GEN_LIBZMQ_TESTS_DIR)
	rm -f $(GEN_LIBZMQ_TESTS_FILE)
	cat templates/ts_header.txt >>  $(GEN_LIBZMQ_TESTS_FILE)
	find  ${LIBZMQ_ROOT}/tests -maxdepth 1 -executable -a -type f -printf "%f  ${LIBZMQ_ROOT}/tests/%f\n" >>  $(GEN_LIBZMQ_TESTS_FILE)
	cat templates/ts_footer.txt >>  $(GEN_LIBZMQ_TESTS_FILE)

tests:  $(GEN_LIBZMQ_TESTS_FILE)
	pybot  $(GEN_LIBZMQ_TESTS_DIR)

clean:
	rm -rf *~   templates/*~ *.html *.xml  $(GEN_LIBZMQ_TESTS_DIR)