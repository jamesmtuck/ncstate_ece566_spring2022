#ifndef DOMINANCE_H
#define DOMINANCE_H

//#include "llvm/Support/DataTypes.h"
//#include "llvm-c/Core.h"
#include "llvm-c/DataTypes.h"
#include "llvm-c/ExternC.h"

LLVM_C_EXTERN_C_BEGIN

LLVMBool LLVMDominates(LLVMValueRef Fun, LLVMBasicBlockRef a, LLVMBasicBlockRef b);
LLVMBool LLVMPostDominates(LLVMValueRef Fun, LLVMBasicBlockRef a, LLVMBasicBlockRef b);

LLVMBasicBlockRef LLVMImmDom(LLVMBasicBlockRef BB);
LLVMBasicBlockRef LLVMImmPostDom(LLVMBasicBlockRef BB);

LLVMBasicBlockRef LLVMNearestCommonDominator(LLVMBasicBlockRef A, LLVMBasicBlockRef B);
unsigned LLVMGetLoopNestingDepth(LLVMBasicBlockRef BB);

LLVMBasicBlockRef LLVMFirstDomChild(LLVMBasicBlockRef BB);
LLVMBasicBlockRef LLVMNextDomChild(LLVMBasicBlockRef BB, LLVMBasicBlockRef Child);
LLVMBool LLVMIsReachableFromEntry(LLVMValueRef Fun, LLVMBasicBlockRef bb);

LLVM_C_EXTERN_C_END

#endif
