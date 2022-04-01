/*
 * File: licm.c
 *
 * Description:
 *   This is where you implement the C version of project 3 support.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* LLVM Header Files */
#include "llvm-c/Core.h"

/* Header file global to this project */
#include "cfg.h"
#include "licm.h"
#include "dominance.h"
#include "transform.h"
#include "stats.h"

LLVMStatisticsRef LICMBasic;
LLVMStatisticsRef LICMLoadHoist;
LLVMStatisticsRef LICMNoPreheader;
LLVMStatisticsRef NumLoops;

void LoopInvariantCodeMotion(LLVMModuleRef Module)
{
    LICMBasic = LLVMStatisticsCreate("LICMBasic", "basic loop invariant instructions");
    LICMLoadHoist = LLVMStatisticsCreate("LICMLoadHoist", "loop invariant load instructions");
    LICMNoPreheader = LLVMStatisticsCreate("LICMNoPreheader", "absence of preheader prevents optimization");

    /* Implement here! */
}
