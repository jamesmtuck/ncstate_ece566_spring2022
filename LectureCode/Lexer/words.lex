%{
#include <stdio.h>
%}


%option noyywrap

%%

.            ;
\n+           printf("newline\n");
[a-z]+       printf("word (%s)\n",yytext);



%%

int main( int argc, char **argv )
{
  ++argv, --argc;  /* skip over program name */
  if ( argc > 0 )
    yyin = fopen( argv[0], "r" );
  else
    yyin = stdin;
  
  yylex();
  return 0;
}

