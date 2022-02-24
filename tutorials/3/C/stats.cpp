/* LLVM Header Files */
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Value.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/FileSystem.h"


#include "stats.h"

using namespace llvm;

LLVMStatisticsRef LLVMStatisticsCreate(const char* name, const char * descr)
{
    Statistic *s = new llvm::Statistic("", name, descr);
    return (LLVMStatisticsRef) s;
}

void LLVMStatisticsInc(LLVMStatisticsRef s)
{
    Statistic *ref = (Statistic*) s;
    (*ref)++;
}

void LLVMEnableStatistics()
{
  EnableStatistics();
}

void LLVMPrintStatistics()
{
  PrintStatistics(errs());
}
