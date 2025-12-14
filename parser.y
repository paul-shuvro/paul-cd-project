%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Declare the lexer function from lexer.l */
int yylex();
void yyerror(const char *s);
%}

/* Token definitions matching lexer.l */
%token TOKEN_KEYWORD
%token TOKEN_IDENTIFIER
%token TOKEN_CONSTANT
%token TOKEN_STRING_LITERAL
%token TOKEN_OPERATOR
%token TOKEN_PUNCTUATOR
%token TOKEN_PREPROCESSOR

/* Operator precedence */
%left '+' '-'
%left '*' '/'
%left UMINUS

%%

program:
      /* empty */
    | program statement
    ;

statement:
      declaration ';'                 { printf("Declaration parsed\n"); }
    | assignment ';'                  { printf("Assignment parsed\n"); }
    | expression ';'                  { printf("Expression parsed\n"); }
    | function_call ';'               { printf("Function call parsed\n"); }
    ;

declaration:
      TOKEN_KEYWORD TOKEN_IDENTIFIER      { /* e.g., int x */ }
    | TOKEN_KEYWORD TOKEN_IDENTIFIER '=' expression
    ;

assignment:
      TOKEN_IDENTIFIER '=' expression
    ;

expression:
      expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | '-' expression %prec UMINUS
    | TOKEN_IDENTIFIER
    | TOKEN_CONSTANT
    | '(' expression ')'
    ;

function_call:
      TOKEN_IDENTIFIER '(' argument_list ')'
    ;

argument_list:
      /* empty */
    | arguments
    ;

arguments:
      expression
    | arguments ',' expression
    ;

%%

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if(argc == 2){
        FILE *f = fopen(argv[1], "r");
        if(!f){ fprintf(stderr, "Cannot open file %s\n", argv[1]); return 1; }
        extern FILE *yyin;
        yyin = f;
    } else {
        printf("Interactive C parser. Ctrl+D to exit.\n> ");
        extern FILE *yyin;
        yyin = stdin;
    }

    yyparse();
    return 0;
}
