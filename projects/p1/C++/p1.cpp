#include <iostream>
#include <unistd.h>
#include <memory>
#include <algorithm>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SystemUtils.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/FileSystem.h"

using namespace llvm;
using namespace std;


unique_ptr<Module> parseP1File(const string &InputFilename);

int
main (int argc, char ** argv)
{
  if (argc < 3) {
    fprintf(stdout,"Usage: %s filein.p1 fileout.bc\n",argv[0]);
    return 0;
  }

  // Remember command line strings
  std::string InputFilename(argv[1]);
  std::string OutputFilename(argv[2]);

  // Make an output file
  std::unique_ptr<ToolOutputFile> Out;  
  std::string ErrorInfo;
  std::error_code EC;
  Out.reset(new ToolOutputFile(OutputFilename.c_str(), EC,
			       sys::fs::OF_None));

  // Do the work
  unique_ptr<Module> M = parseP1File(InputFilename);

  // If successful, produce LLVM bitcode
  if (M.get() != nullptr) // if we get a valid module back
    {
      // Write the bitcode file out.
      WriteBitcodeToFile(*M.get(),Out->os());    
      // Keep the output file.
      Out->keep();
    }
  else
    {
      std::cout << "Errors. No module produced." << std::endl;
      return 1;
    }
  
  return 0;
}

