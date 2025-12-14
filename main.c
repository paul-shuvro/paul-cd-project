#include <stdio.h>
#include <stdlib.h>

/* Include Bison parser header */
#include "parser.tab.h"

/* Declare external lexer input file */
extern FILE *yyin;

/* Declare the parser function from Bison */
int yyparse(void);

/* Error handler from parser.y */
void yyerror(const char *s);

/* Optional: function to print tokens from lexer (from lexer.l) */
extern int yylex();
extern int yylineno;
extern char *yytext;

int main(int argc, char *argv[]) {
    printf("========================================\n");
    printf("      C Tokenizer + Parser (Flex/Bison)\n");
    printf("========================================\n\n");

    if (argc == 2) {
        /* Read from file */
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
            return 1;
        }
        printf("Parsing file: %s\n\n", argv[1]);
    } else {
        /* Interactive mode */
        printf("Interactive Mode (Enter C code, Ctrl+D to exit):\n");
        yyin = stdin;
    }

    /* Parse the input */
    int parse_status = yyparse();

    if(parse_status == 0) {
        printf("\nParsing completed successfully!\n");
    } else {
        printf("\nParsing finished with errors.\n");
    }

    if (yyin != stdin) fclose(yyin);

    printf("========================================\n");
    return 0;
}
