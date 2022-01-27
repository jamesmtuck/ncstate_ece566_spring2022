%{
#include <stdio.h>
#include <iostream>
#include <math.h>
#include "expr.y.hpp" 
%}


%option noyywrap

%% // begin tokens

[ \n\t]  // ignore a space, a tab, a newline

[Rr][0-7] { //printf("REG(%s)\n", yytext+1);
            yylval.reg = atoi(yytext+1);  return REG; }
[0-9]+    { //printf("IMMEDIATE(%s)\n",yytext);
            yylval.imm = atoi(yytext);
            return IMMEDIATE; }
"="       { //printf("ASSIGN\n");
            return ASSIGN; }
;         { //printf("SEMI\n");
            return SEMI; }
"("       { //printf("LPAREN\n");
            return LPAREN; } 
")"       { //printf("RPAREN\n");
            return RPAREN; } 
"["       { //printf("LBRACKET\n");
            return LBRACKET; } 
"]"       { //printf("RBRACKET\n");
            return RBRACKET; } 
"-"       { //printf("MINUS\n");
            return MINUS; } 
"+"       { //printf("PLUS\n");
            return PLUS; } 

"//".*\n

.         { printf("syntax error!\n"); exit(1); }

%% // end tokens

// put more C code that I want in the final scanner
