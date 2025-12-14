# Compiler/Tools
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -Wall -g

# Source files
LEX_SRC = ../lexer.l
YACC_SRC = ../parser.y
MAIN_SRC = ../main.c

# Generated files
LEX_OUT = lexer.c
YACC_OUT = parser.tab.c
YACC_HDR = parser.tab.h

# Object files
OBJ = lexer.o parser.o main.o

# Executable
EXE = cparser.exe

all: $(EXE)

# Step 1: Generate parser from Bison
parser.tab.c parser.tab.h: $(YACC_SRC)
	$(BISON) -d -v $(YACC_SRC)

# Step 2: Generate lexer from Flex
lexer.c: $(LEX_SRC) parser.tab.h
	$(FLEX) -o lexer.c $(LEX_SRC)

# Step 3: Compile all
lexer.o: lexer.c parser.tab.h
	$(CC) $(CFLAGS) -c lexer.c

parser.o: parser.tab.c parser.tab.h
	$(CC) $(CFLAGS) -c parser.tab.c

main.o: $(MAIN_SRC)
	$(CC) $(CFLAGS) -c $(MAIN_SRC)

# Step 4: Link executable
$(EXE): $(OBJ)
	$(CC) $(CFLAGS) -o $(EXE) $(OBJ) -lfl

# Clean build
clean:
	rm -f *.o lexer.c parser.tab.c parser.tab.h parser.output $(EXE)
