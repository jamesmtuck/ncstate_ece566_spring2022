LLVMCONFIG=llvm-config-11

LLVMINCLUDE=$(shell $(LLVMCONFIG) --includedir)

LLVMLIBS=$(shell $(LLVMCONFIG) --libs --system-libs)
LLVMLIBDIR=$(shell $(LLVMCONFIG) --libdir)

CLANGXX = clang++-11
CLANG = clang-11

all:
	@bison -y -d -o calc.y.c calc.y
	@flex -ocalc.lex.c calc.lex
	@$(CLANG) -o calc.lex.o -c calc.lex.c $(shell $(LLVMCONFIG) --cflags)
	@$(CLANG) -o calc.y.o -c calc.y.c $(shell $(LLVMCONFIG) --cflags)
	@$(CLANG) -o main.o -c main.c $(shell $(LLVMCONFIG) --cflags)
	@$(CLANGXX)  $(shell $(LLVMCONFIG) --cxxflags --ldflags) -m64 -I$(LLVMINCLUDE) -L$(LLVMLIBDIR) -o calc main.o calc.y.o calc.lex.o -ll $(LLVMLIBS)
	@echo [Built calc.]
clean:
	@rm -Rf calc.lex.cpp calc.y.cpp *.o calc.y.hpp calc *~ *.bc *.ll
	@echo [Clean.]
