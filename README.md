ZeroMQ QA Testsuite (ZMQA)
================================

This is the ZeroMQ testsuite based on RobotFramework test-framework.

The intention of this project is to create a portable ZeroMQ testsuite
being used on various target systems and environments.

ØMQ (also known as ZeroMQ, 0MQ, or zmq) looks like an embeddable
networking library but acts like a concurrency framework. It gives you
sockets that carry atomic messages across various transports like
in-process, inter-process, TCP, and multicast. You can connect sockets
N-to-N with patterns like fan-out, pub-sub, task distribution, and
request-reply. It's fast enough to be the fabric for clustered
products. Its asynchronous I/O model gives you scalable multicore
applications, built as asynchronous message-processing tasks. It has a
score of language APIs and runs on most operating systems. ØMQ is from
iMatix and is LGPLv3 open source.

Robot Framework is a generic test automation framework for acceptance
testing and acceptance test-driven development (ATDD). It has
easy-to-use tabular test data syntax and it utilizes the
keyword-driven testing approach. Its testing capabilities can be
extended by test libraries implemented either with Python or Java, and
users can create new higher-level keywords from existing ones using
the same syntax that is used for creating test cases.

Please see the following projects to get to know more about both
projects:

- ZeroMQ http://zeromq.org/
- Robot Framewwork System Test Framework  http://robotframework.org/

Prerequisites
-------------------------
The following command installs the required libraries for Ubuntu-12.04 and later to build libzmq and corresponding test binaries. (otherwise "make build-libzmq" might fail)
```
sudo apt-get install autogen libtool autoconf libpgm-dev gcc g++ gdb python-pip
```

Installation and Testing
-------------------------

1. Install required Python libraries

   Follow RobotFramework installation guide
   http://robotframework.org. You will require version starting from
   2.8.1 or from latest version fromrepository.
 
   If you are familiar with installing Python packages and have pip
   available, just run the following command:
```
   sudo pip install robotframework
```
   If chart diagrams shall be embedded into the test-logs as well, 
   install svg.charts Python libraries. [docs/screenshot-report.png](docs/screenshot-report.png)

   Note: Please install version 2.0.4 and avoid version 2.1 as the
   latter package lacks a file (readme.txt) and can not be installed.
``` 
   sudo pip install svg.charts=2.0.4 
```

2. Now checkout this project.
```
   ## Checkout the latest testsuite version from repository
   git clone https://github.com/frehberg/zeromq_testsuite.git
   
   ## Enter the directory
   cd zeromq_testsuit/
```


3. [For release testing] Prepare your build of LibZMQ and set the
   folowing environment variables LIBZMQ_ROOT, CFLAGS and CXXFLAGS. 

   If you don't have the libzmq build environment yet, the following
   command will checkout, build libzmq. The binaries will be installed
   with prefix PREFIX=${HOME}/opt/
```
   ### In root directory of zeromq_testsuite/ enter
   make build-libzmq PREFIX=${HOME}/opt/
```

   In this case the required environment variables would look like:
```
   export LIBZMQ_ROOT=${PWD}/build/src/libzmq
   export CFLAGS=-I ${HOME}/opt/include
   export CXXFLAGS=-L ${HOME}/opt/lib
```
 
4. Perform the tests. A test-report will be written to the local directory: 
```
   make test-release
```
   In case one wants to perform latency tests only, execute the following make task:
```
   make test-latency
```
   In case one wants to perform throughput tests only, execute the following make task:
```
   make test-throughput
```
  
5. Open the test-report with a web-browser for review. The test-report
   allows you to dig into to investigate which step the testcase did
   cause the failure.
```
    firefox  report.html
```

Once everything has been installed and is in place the step 4+5 can be
repeated as often as you like.

Roadmap
-------------------------
- Implement remote tests being executed on two hosts
- Implement security tests
- Cover the test-apps of zeromq/issues/ as regression tests
- Implement tests for various wrappers, for example Java
- Implement tests using ProtoBuf payload encoding and compare with raw encoding
- Improve the SVG chart-diagram processor, embedding SVG into the report.html wihtout external files or dependencies.



