%{
#include <cstdio>
#include <list>
#include <iostream>
#include <string>
#include <memory>
#include <stdexcept>

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
using namespace std;

extern FILE *yyin;
int yylex();
void yyerror(const char*);

extern "C" {
  int yyparse();
}

// helper code 
template<typename ... Args>
std::string format( const std::string& format, Args ... args )
{
    size_t size = snprintf( nullptr, 0, format.c_str(), args ... ) + 1; // Extra space for '\0'
    if( size <= 0 ){ throw std::runtime_error( "Error during formatting." ); }
    std::unique_ptr<char[]> buf( new char[ size ] ); 
    snprintf( buf.get(), size, format.c_str(), args ... );
    return std::string( buf.get(), buf.get() + size - 1 ); // We don't want the '\0' inside
}

int regCnt = 8;
 
%}

%verbose
%define parse.trace

%union {
  int reg;
  int imm;
}
// Put this after %union and %token directives

%token <reg> REG
%token <imm> IMMEDIATE
%token RETURN ASSIGN SEMI PLUS MINUS LPAREN RPAREN LBRACKET RBRACKET

%type expr

%left  PLUS MINUS


%%

program:   REG ASSIGN expr SEMI
{

}
| program REG ASSIGN expr SEMI
{

}
| program RETURN REG SEMI
{

  
  return 0;
}
;

expr:    	  IMMEDIATE
{

}
| REG
{ 

}
| expr PLUS expr
{

}
| expr MINUS expr
{

}
| LPAREN expr RPAREN
{

}
| MINUS expr
{

}
| LBRACKET expr RBRACKET
{

}
;

%%

void yyerror(const char* msg)
{
  printf("%s",msg);
}

int main(int argc, char *argv[])
{
  yydebug = 0;
  yyin = stdin; // get input from screen

  // Now we’re ready to make IR, call yyparse()
  if (yyparse() == 0)
  {
    // do something

  } else {
    printf("There was a problem! Read the error messages.");
  }
  return 0;
}
