.PHONY: all clean

LLVMCONFIG=llvm-config
CXX = g++
CXXFLAGS = -g -std=c++14 -Wall -Wno-deprecated-register \
           -Wno-unneeded-internal-declaration \
           -Wno-unused-function

all:
	flex -o p1.lex.cpp p1.lex
	bison -d -o p1.y.cpp p1.y
	$(CXX) $(CXXFLAGS) -c -o p1.lex.o p1.lex.cpp `$(LLVMCONFIG) --cppflags`
	$(CXX) $(CXXFLAGS) -c -o p1.y.o p1.y.cpp `$(LLVMCONFIG) --cppflags`
	$(CXX) $(CXXFLAGS) -c -o p1.o p1.cpp `$(LLVMCONFIG) --cppflags`
	$(CXX) $(CXXFLAGS) -o p1 p1.o p1.y.o p1.lex.o -ly -ll `$(LLVMCONFIG) --ldflags --libs --system-libs`

clean:
	rm -Rf p1 *.o p1.y.cpp p1.y.hpp p1.lex.cpp
