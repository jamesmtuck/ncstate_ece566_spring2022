%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "llvm-c/Core.h"
  
// Need for parser and scanner
extern FILE *yyin;
int yylex();
void yyerror(const char*);
int yyparse();
 
// Needed for LLVM
char* funName;
LLVMModuleRef M;
LLVMBuilderRef  Builder;

 typedef struct string_list_node_def {
   struct string_list_node_def *next;
   const char *str;
 } string_list_node;

 typedef struct {
   string_list_node *head;
   string_list_node *tail;
 } string_list;

 string_list* string_list_create() {
   string_list *list = malloc(sizeof(string_list));
   list->head = NULL;
   list->tail = NULL;
   return list;
 }
 
 void string_list_append(string_list *list, const char * str)
 {
   string_list_node *node = malloc(sizeof(string_list_node));
   node->str = str;
   node->next = NULL;
   if (list->tail) {
     list->tail->next = node;
     list->tail = node;
   } else {
     list->head = list->tail = node;
   }
 }
 
%}

%union {
  string_list *params_list;
}

/*%define parse.trace*/

%type <params_list> params_list

%token IN FINAL
%token ERROR
%token NUMBER
%token ID 
%token BINV INV PLUS MINUS XOR AND OR MUL DIV MOD
%token COMMA ENDLINE ASSIGN LBRACKET RBRACKET LPAREN RPAREN NONE COLON
%token REDUCE EXPAND

%precedence BINV
%precedence INV
%left PLUS MINUS OR
%left MUL DIV AND XOR MOD

%start program

%%

program: inputs statements_opt final
{
  YYACCEPT;
}
;

inputs:   IN params_list ENDLINE
{  
  string_list_node *tmp = $2->head;
  int cnt=0;
  while(tmp)
    {
      cnt++;
      tmp = tmp->next;
    }

  LLVMTypeRef *paramTypes = malloc(sizeof(LLVMTypeRef)*cnt);
  for(int i=0; i<cnt; i++)
    paramTypes[i] = LLVMInt32Type();
  
  LLVMTypeRef IntFnTy = LLVMFunctionType(LLVMInt32Type(),paramTypes,0,0);

  // Make a void function named main (the start of the program!)
  LLVMValueRef Fn = LLVMAddFunction(M,funName,IntFnTy);

  // Add a basic block to main to hold new instructions
  LLVMBasicBlockRef BB = LLVMAppendBasicBlock(Fn,"entry");

  // Create a Builder object that will construct IR for us
  Builder = LLVMCreateBuilder();
  // Ask builder to place new instructions at end of the
  // basic block
  LLVMPositionBuilderAtEnd(Builder,BB);
  
}
| IN NONE ENDLINE
{ 
  // Make a void function type with no arguments
  LLVMTypeRef IntFnTy = LLVMFunctionType(LLVMInt32Type(),NULL,0,0);

  // Make a void function named main (the start of the program!)
  LLVMValueRef Fn = LLVMAddFunction(M,funName,IntFnTy);

  // Add a basic block to main to hold new instructions
  LLVMBasicBlockRef BB = LLVMAppendBasicBlock(Fn,"entry");

  // Create a Builder object that will construct IR for us
  Builder = LLVMCreateBuilder();
  // Ask builder to place new instructions at end of the
  // basic block
  LLVMPositionBuilderAtEnd(Builder,BB);
}
;

params_list: ID
{
  $$ = string_list_create();
  string_list_append($$,"");
  // add ID to vector
}
| params_list COMMA ID
{
  // add ID to $1
}
;

final: FINAL ensemble endline_opt
{
  // FIX ME, ALWAYS RETURNS 0
  LLVMBuildRet(Builder,LLVMConstInt(LLVMInt32Type(),0,0));
}
;

endline_opt: %empty | ENDLINE;
            

statements_opt: %empty
            | statements;

statements:   statement 
            | statements statement 
;

statement: ID ASSIGN ensemble ENDLINE
| ID NUMBER ASSIGN ensemble ENDLINE
| ID LBRACKET ensemble RBRACKET ASSIGN ensemble ENDLINE
;

ensemble:  expr
| expr COLON NUMBER                  // 566 only
| ensemble COMMA expr
| ensemble COMMA expr COLON NUMBER   // 566 only
;

expr:   ID
| ID NUMBER
| NUMBER
| expr PLUS expr
| expr MINUS expr
| expr XOR expr
| expr AND expr
| expr OR expr
| INV expr
| BINV expr
| expr MUL expr
| expr DIV expr
| expr MOD expr
| ID LBRACKET ensemble RBRACKET
| LPAREN ensemble RPAREN
/* 566 only */
| LPAREN ensemble RPAREN LBRACKET ensemble RBRACKET
| REDUCE AND LPAREN ensemble RPAREN
| REDUCE OR LPAREN ensemble RPAREN
| REDUCE XOR LPAREN ensemble RPAREN
| REDUCE PLUS LPAREN ensemble RPAREN
| EXPAND  LPAREN ensemble RPAREN
;

%%

LLVMModuleRef parseP1File(const char* InputFilename)
{
  // Figure out function name
  char *pos = strrchr(InputFilename,'/');
  if (pos)
    funName = strdup(pos+1);
  else 
    funName = strdup(InputFilename);
  pos = strchr(funName,'.');
  if (pos) *pos = 0;

  // Make Module
  M = LLVMModuleCreateWithName(funName);
  
  yyin = fopen(InputFilename,"r");

  //yydebug = 1;
  if (yyparse() != 0) {
    // errors, so discard module
    return NULL;
  } else {
    LLVMDumpModule(M);
    return M;
  }
}

void yyerror(const char* msg)
{
  printf("%s\n",msg);
}
