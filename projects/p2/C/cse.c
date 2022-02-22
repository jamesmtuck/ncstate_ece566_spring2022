/*
 * File: CSE.c
 *
 * Description:
 *   This is where you implement the C version of project 2 support.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* LLVM Header Files */
#include "llvm-c/Core.h"

/* Header file global to this project */
#include "cfg.h"
#include "cse.h"
#include "dominance.h"
#include "transform.h"
#include "stats.h"

LLVMStatisticsRef CSEDead;
LLVMStatisticsRef CSEElim;
LLVMStatisticsRef CSESimplify;
LLVMStatisticsRef CSELdElim;
LLVMStatisticsRef CSEStore2Load;
LLVMStatisticsRef CSEStElim;

void CommonSubexpressionElimination(LLVMModuleRef Module)
{
    CSEDead = LLVMStatisticsCreate("CSEDead", "CSE found dead instructions");
    CSEElim = LLVMStatisticsCreate("CSEElim", "CSE redundant instructions");
    CSESimplify = LLVMStatisticsCreate("CSESimplify", "CSE simplified instructions");
    CSELdElim = LLVMStatisticsCreate("CSELdElim", "CSE redundant loads");
    CSEStore2Load = LLVMStatisticsCreate("CSEStore2Load", "CSE forwarded store to load");
    CSEStElim = LLVMStatisticsCreate("CSEStElim", "CSE redundant stores");

    /* Implement here! */

    LLVMStatisticsInc(CSEDead);
}
