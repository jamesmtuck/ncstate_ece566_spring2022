%{
#include <cstdio>
#include <list>
#include <iostream>
#include <string>
#include <memory>
#include <stdexcept>

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
%token ASSIGN SEMI PLUS MINUS LPAREN RPAREN LBRACKET RBRACKET

%type <reg> expr

%left  PLUS MINUS



%%

program:   REG ASSIGN expr SEMI
{
  printf("# Output of program: REG ASSIGN expr SEMI\n");
  printf("ADD R%d, R%d, 0\n",$1, $3); // add immediate
  printf("# End of program\n");
  return 0;
}
;

expr:    	  IMMEDIATE
{
   int r = regCnt++; // get the next free register 
   printf("# Output of expr: IMMEDIATE\n");
   printf("AND R%d, R%d, 0\n",r,r);      // clear a register
   printf("ADD R%d, R%d, %d\n",r, r, $1); // add immediate
   $$ = r; //specify which register holds the result
}
| REG
{ 
  $$ = $1;  
}
| expr PLUS expr
{
   int r = regCnt++; // get the next free register 
   printf("# Output of expr: expr PLUS expr\n");
   printf("ADD R%d, R%d, R%d\n",r,$1, $3); // add immediate
   $$ = r; //specify which register holds the result
}
| expr MINUS expr
{
   int r = regCnt++; // get the next free register 
   printf("# Output of expr: expr MINUS expr\n");
   printf("SUB R%d, R%d, R%d\n",r,$1, $3); // add immediate
   $$ = r; //specify which register holds the result
}
| LPAREN expr RPAREN
{
  $$ = $2;
}
| MINUS expr
{
   int r = regCnt++; // get the next free register 
   printf("# Output of expr: MINUS expr\n");
   printf("NOT R%d, R%d\n",r, $2); // add immediate
   printf("ADD R%d, R%d, 1\n",r, r); // add immediate
   $$ = r; //specify which register holds the result
}
| LBRACKET expr RBRACKET
{
   int r = regCnt++; // get the next free register 
   printf("# Output of expr: [ expr ]\n");
   printf("LDR R%d, R%d, 0\n",r, $2); // add immediate
   $$ = r; //specify which register holds the result  
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
  yyin = stdin;
  yyparse();
  return 0;
}
