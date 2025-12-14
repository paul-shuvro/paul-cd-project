%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX_TOKEN_VALUE 256

typedef enum {
    TOKEN_KEYWORD,
    TOKEN_IDENTIFIER,
    TOKEN_CONSTANT,
    TOKEN_STRING_LITERAL,
    TOKEN_OPERATOR,
    TOKEN_PUNCTUATOR,
    TOKEN_PREPROCESSOR,
    TOKEN_WHITESPACE,
    TOKEN_UNKNOWN
} TokenType;

int current_line = 1;
int current_column = 1;

extern FILE *yyin; // Flex input file

void print_token(TokenType type, const char* val);
void update_position(const char* text);
%}

%option noyywrap
%option yylineno

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*
INT         {DIGIT}+
FLOAT       {DIGIT}+\.{DIGIT}*([eE][+-]?{DIGIT}+)?
WS          [ \t]+
NEWLINE     \n

KEYWORDS    "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"

OPERATORS   "++"|"--"|"="|"=="|"!="|"+="|"-="|"*="|"/="|"%="|"<="|">="|"&&"|"||"|"!"|"<"|">"|"+"|"-"|"*"|"/"|"%"|"&"|"|"|"^"|"~"|"<<"|">>"|"->" 
PUNCTUATORS ";"|","|"."|"("|")"|"["|"]"|"{"|"}"

%%

"//".*                      { update_position(yytext); }
"/*"([^*]|\*+[^*/])*\*+"/"  { update_position(yytext); }

{WS}                         { update_position(yytext); }
{NEWLINE}                    { current_line++; current_column=1; }

^"#"[ \t]*{ID}               { print_token(TOKEN_PREPROCESSOR, yytext); update_position(yytext); }

{KEYWORDS}                   { print_token(TOKEN_KEYWORD, yytext); update_position(yytext); }
{ID}                          { print_token(TOKEN_IDENTIFIER, yytext); update_position(yytext); }

{FLOAT}                       { print_token(TOKEN_CONSTANT, yytext); update_position(yytext); }
{INT}                         { print_token(TOKEN_CONSTANT, yytext); update_position(yytext); }

\"([^\\"]|\\.)*\"             { print_token(TOKEN_STRING_LITERAL, yytext); update_position(yytext); }
\'([^\\']|\\.)\'              { print_token(TOKEN_CONSTANT, yytext); update_position(yytext); }

{OPERATORS}                   { print_token(TOKEN_OPERATOR, yytext); update_position(yytext); }
{PUNCTUATORS}                 { print_token(TOKEN_PUNCTUATOR, yytext); update_position(yytext); }

.                             { print_token(TOKEN_UNKNOWN, yytext); update_position(yytext); }

%%

void update_position(const char* text) {
    for (int i=0; text[i]; i++) {
        if(text[i]=='\n'){ current_line++; current_column=1; }
        else current_column++;
    }
}

void print_token(TokenType type, const char* val) {
    const char* type_name;
    switch(type){
        case TOKEN_KEYWORD: type_name="KEYWORD"; break;
        case TOKEN_IDENTIFIER: type_name="IDENTIFIER"; break;
        case TOKEN_CONSTANT: type_name="CONSTANT"; break;
        case TOKEN_STRING_LITERAL: type_name="STRING_LITERAL"; break;
        case TOKEN_OPERATOR: type_name="OPERATOR"; break;
        case TOKEN_PUNCTUATOR: type_name="PUNCTUATOR"; break;
        case TOKEN_PREPROCESSOR: type_name="PREPROCESSOR"; break;
        case TOKEN_WHITESPACE: type_name="WHITESPACE"; break;
        default: type_name="UNKNOWN"; break;
    }
    printf("[Line %3d, Col %3d] %-15s %s\n", current_line, current_column - (int)strlen(val), type_name, val);
}
