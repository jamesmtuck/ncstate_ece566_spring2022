%{
#include <stdio.h>
#include <math.h>

#include "llvm-c/Core.h"

 typedef struct string_list_node_def {
   struct string_list_node_def *next;
   const char *str;
 } string_list_node;

 typedef struct {
   string_list_node *head;
   string_list_node *tail;
 } string_list;
  
#include "p1.y.h"

%}

   //%option debug

%%

[ \t]         //ignore

in            { return ERROR; }
final         { return ERROR; }
none          { return ERROR;  }

[a-zA-Z]+     { return ERROR; }
[0-9]+        { return ERROR; }

"["           { return ERROR; }
"]"           { return ERROR; }
"("           { return ERROR; }
")"           { return ERROR; }

"="           { return ERROR; }
"*"           { return ERROR; }
"%"           { return ERROR; }
"/"           { return ERROR; }
"+"           { return ERROR; }
"-"           { return ERROR; }

"^"           { return ERROR; }
"|"           { return ERROR; }
"&"           { return ERROR; }

"~"           { return ERROR; }
"!"           { return ERROR; }


","           { return ERROR; }

\n            { return ERROR; }


"//".*\n      { }

.             { return ERROR; }
%%

int yywrap()
{
  return 1;
}
