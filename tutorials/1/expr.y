%{
#include <cstdio>
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

%}

%verbose
%define parse.trace

%union {

}
// Put this after %union and %token directives

%token REG
%token IMMEDIATE
%token ASSIGN SEMI PLUS MINUS LPAREN RPAREN LBRACKET RBRACKET

%left  PLUS MINUS


%%

program:   REG ASSIGN expr SEMI

;

expr:    	  IMMEDIATE
| REG
| expr PLUS expr
| expr MINUS expr
| LPAREN expr RPAREN
| MINUS expr
| LBRACKET expr RBRACKET
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
