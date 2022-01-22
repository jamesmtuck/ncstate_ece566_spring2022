#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <set>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SystemUtils.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/FileSystem.h"

#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"

using namespace llvm;

int Count(Module &M) {
  int count = 0;
  for(auto f = M.begin(); f!=M.end(); f++)
    for(auto bb = f->begin(); bb!=f->end(); bb++)
      for(auto i = bb->begin(); i!=bb->end(); i++, count++);

  return count;
}

int main (int argc, char ** argv)
{  
  if (argc < 2) {
    fprintf(stdout,"Not enough positional arguments to %s.\n",argv[0]);
    return 0;
  }
  
  LLVMContext *Context = new LLVMContext();
  long long count = 0;
  std::unique_ptr<Module> M;
  
  for(int i=1; i<argc; i++)
    {
      SMDiagnostic Err;
      M = parseIRFile(argv[i], Err, *Context);
      
      if (M.get() == 0) {
	Err.print(argv[0], errs());
	return 0;
      }  
      
      bool res = verifyModule(*M, &errs());
      if (!res) {
	int tmp = Count(*M);
	std::cout << argv[i] << ": " << tmp << std::endl;	
	count += tmp;
      } else {
	std::cout << "Error in module " << argv[i] << "." << std::endl;
	return 1;
      }
    }

  std::cout << "Total = " << count << std::endl;
  
  return 0;
}

