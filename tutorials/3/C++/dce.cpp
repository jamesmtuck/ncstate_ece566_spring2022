// dce.cpp

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

#include "llvm/ADT/Statistic.h"

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SystemUtils.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/FileSystem.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/LinkAllPasses.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/SourceMgr.h"

#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"

#include "llvm/Support/CommandLine.h"

using namespace llvm;

static cl::opt<std::string>
        InputFilename(cl::Positional, cl::desc("<input bitcode>"), cl::Required, cl::init("-"));

static cl::opt<std::string>
        OutputFilename(cl::Positional, cl::desc("<output bitcode>"), cl::Required, cl::init("out.bc"));

static cl::opt<bool>
        Mem2Reg("mem2reg",
                cl::desc("Perform memory to register promotion before CSE."),
                cl::init(false));

static cl::opt<bool>
        Verbose("verbose",
                cl::desc("Verbosely print lots of status messages to the screen."),
                cl::init(false));


static llvm::Statistic DeadInst = {"", "Dead", "DCE found dead instructions"};
static llvm::Statistic WorkList = {"", "WorkList", "Added to work list"};

void NoOptimization(Module &M) {
    // Do nothing! Simplest optimization that exists
}

void RunDeadCodeElimination(Module &M) {

}

int main(int argc, char **argv) {
    cl::ParseCommandLineOptions(argc, argv, "./dce <input> <output> \n");

    // LLVM idiom for constructing output file.
    std::unique_ptr<ToolOutputFile> Out;
    std::string ErrorInfo;
    std::error_code EC;
    Out.reset(new ToolOutputFile(OutputFilename, EC,
                                 sys::fs::F_None));

    SMDiagnostic Err;
    std::unique_ptr<Module> M;
    LLVMContext *Context = new LLVMContext();
    M = parseIRFile(InputFilename, Err, *Context);

    if (M.get() == 0) {
        Err.print(argv[0], errs());
        return 1;
    }

    EnableStatistics();

    if (Mem2Reg) {
        if (Verbose)
            errs() << "Run Mem2Reg.\n";
        legacy::PassManager Passes;
        Passes.add(createPromoteMemoryToRegisterPass());
        Passes.run(*M.get());
    }
    if (Verbose)
        M->print(errs(), nullptr);

    /* 3. Do optimization on Module */
    //NoOptimization(*M.get());
    //RunDeadCodeElimination(*M.get());

    bool res = verifyModule(*M, &errs());
    if (!res) {
        WriteBitcodeToFile(*M.get(), Out->os());
        Out->keep();
    } else {
        fprintf(stderr, "Error: %s not created.\n", argv[2]);
    }

    PrintStatistics(errs());

    return 0;
}


