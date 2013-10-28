##    Copyright (c) 2007-2013 Contributors as noted in the AUTHORS file
##
##    This file is part of 0MQ-Testsuite.
##
##    0MQ-Testsuite is free software; you can redistribute it and/or
##    modify it under the terms of the GNU Lesser General Public License
##    as published by the Free Software Foundation; either version 3 of
##    the License, or (at your option) any later version.
##
##    0MQ-Testsuite is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
##    Lesser General Public License for more details.
##
##    You should have received a copy of the GNU Lesser General Public License
##    along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
