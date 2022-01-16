
%{
#include <stdio.h>

extern FILE *yyin;

int yyerror(char*);

int yylex();
 %}

%union {
  int val;
}

%token PLUS MINUS LPAREN RPAREN NEWLINE MULTIPLY DIVIDE

%token <val> NUMBER
%type <val>  expr 

%left PLUS MINUS
%left MULTIPLY DIVIDE

%start expr_list

%%

expr_list:  NEWLINE                    {}
            |  expr NEWLINE            { printf("=%d\n",$1); }
            | expr_list expr NEWLINE  { printf("=%d\n",$2); }
            | expr_list NEWLINE {}
;

expr :   expr PLUS expr                  { $$ = $1 + $3; }
       | expr MINUS expr                 { $$ = $1 - $3; } 
       | expr MULTIPLY expr                 { $$ = $1 * $3; } 
| expr DIVIDE expr                 { if ($3 != 0) $$ = $1 / $3;  else { printf("Don't divide by zero please!\n"); $$=0; } } 
       | LPAREN expr RPAREN              { $$ = $2; }
        | NUMBER                          { $$ = $1 ; }
       | MINUS expr                      { $$ = - $2 ; }
;

%%

/* int main() */
/* { */
/*   yyin = stdin; */
/*   yyparse(); */
/*   return 0; */
/* } */

int yyerror(char *msg) {
  printf("%s",msg);
  return 0;
}
