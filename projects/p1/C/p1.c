#include <stdio.h>
#include <unistd.h>
#include <string.h>

#include "llvm-c/Core.h"
#include "llvm-c/BitReader.h"
#include "llvm-c/BitWriter.h"

LLVMModuleRef parseP1File(const char* InputFilename);

int
main (int argc, char ** argv)
{
  if (argc < 3) {
    fprintf(stdout,"Usage: %s filein.p1 fileout.bc\n",argv[0]);
    return 0;
  }

  // Remember command line strings
  const char * InputFilename = strdup(argv[1]);
  const char * OutputFilename = strdup(argv[2]);

  // Do the work
  LLVMModuleRef M = parseP1File(InputFilename);

  // If successful, produce LLVM bitcode
  if (M != NULL) // if we get a valid module back
    {
      // Write module to file
      LLVMWriteBitcodeToFile(M,OutputFilename);
    }
  else
    {
      printf("Errors. No module produced.\n");
      return 1;
    }
  
  return 0;
}

