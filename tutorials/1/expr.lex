%{
#include <stdio.h>
#include <iostream>
#include <math.h>
#include "expr.y.hpp" 
%}


%option noyywrap

%% // begin tokens

"+"       printf("PLUS ");

%% // end tokens

// put more C code that I want in the final scanner
