
BUILD_DIR=$(PWD)/build
SRC_DIR=$(BUILD_DIR)/src

## define variable PREFIX if not set yet
PREFIX ?= $(BUILD_DIR)

src/libsodium:
	mkdir -p $(PREFIX)
	mkdir -p $(SRC_DIR)
	cd $(SRC_DIR); git clone https://github.com/jedisct1/libsodium.git
	cd $(SRC_DIR)/libsodium && ./autogen.sh && ./configure --prefix=$(PREFIX); make && make install

src/libzmq:
	mkdir -p $(PREFIX)
	mkdir -p $(SRC_DIR)
	cd $(SRC_DIR); git clone git://github.com/zeromq/libzmq.git
	cd $(SRC_DIR)/libzmq  && ./autogen.sh && ./configure --disable-option-checking --prefix=$(PREFIX) --with-libsodium=$(PREFIX) --with-pgm CXXFLAGS=-Wno-long-long  --srcdir=. && make && make install


build-libzmq:  src/libsodium  src/libzmq
	@echo "Libzmq has been build and installed to $(PREFIX)"
	@echo "set the following variables to perform the testing"
	@echo "  export LIBZMQ_ROOT=$(SRC_DIR)/libzmq"
	@echo "  export CXXFLAGS=-L $(PREFIX)/lib "
	@echo "  export CFLAGS=-I $(PREFIX)/include "
