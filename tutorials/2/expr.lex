%{
#include <stdio.h>
#include <iostream>
#include <math.h>

#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/IRBuilder.h"

#include "llvm/Bitcode/BitcodeReader.h"
#include "llvm/Bitcode/BitcodeWriter.h"
#include "llvm/Support/SystemUtils.h"
#include "llvm/Support/ToolOutputFile.h"
#include "llvm/Support/FileSystem.h"

using namespace llvm;

#include "expr.y.hpp" 
%}


%option noyywrap

%% // begin tokens

[ \n\t]  // ignore a space, a tab, a newline

[Rr][0-7] { 
            yylval.reg = atoi(yytext+1);  return REG;
          }
[0-9]+    { 
            yylval.imm = atoi(yytext);
            return IMMEDIATE;
          }
"="       { 
            return ASSIGN; }
;         { 
            return SEMI;
          }
"("       { 
            return LPAREN;
          }
")"       { 
            return RPAREN;
          } 
"["       { 
            return LBRACKET;
          } 
"]"       { 
            return RBRACKET;
          } 
"-"       { 
            return MINUS;
          } 
"+"       { 
            return PLUS;
          } 
return    {
            return RETURN;
          }

"//".*\n

.         { printf("syntax error!\n"); exit(1); }

%% // end tokens

// put more C code that I want in the final scanner
