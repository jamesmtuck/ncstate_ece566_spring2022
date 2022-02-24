#ifndef STATS_H
#define STATS_H

//#include "llvm/Support/DataTypes.h"
//#include "llvm-c/Core.h"
#include "llvm-c/DataTypes.h"
#include "llvm-c/ExternC.h"

LLVM_C_EXTERN_C_BEGIN

typedef struct LLVMStatisticsOpaque *LLVMStatisticsRef;

LLVMStatisticsRef LLVMStatisticsCreate(const char* name, const char * descr);
void LLVMStatisticsInc(LLVMStatisticsRef s);

void LLVMEnableStatistics(void);
void LLVMPrintStatistics(void);

LLVM_C_EXTERN_C_END

#endif
