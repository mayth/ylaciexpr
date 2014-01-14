PROG := ylaciexpr list-test trie-test
CC := clang
CFLAGS=-g -Wall -std=c99 -DYYERROR_VERBOSE -DYYDEBUG

ylaciexpr: expr.o AST.o trie.o list.o interpreter.c
	$(CC) $(CFLAGS) -o ylaciexpr expr.o AST.o trie.o list.o

test-components: list-test trie-test

list-test: list.o list_test.c
	$(CC) $(CFLAGS) -o list_test list.o list_test.c

trie-test: trie.o trie_test.c
	$(CC) $(CFLAGS) -o trie_test trie.o trie_test.c

all: $(PROG)

AST.o: AST.h AST.c trie.o list.o
	$(CC) $(CFLAGS) -c AST.c

trie.o: trie.h trie.c
	$(CC) $(CFLAGS) -c trie.c

list.o: list.h list.c
	$(CC) $(CFLAGS) -c list.c

expr.o: expr.y lexer.c interpreter.c
	yacc $(YACCFLAGS) expr.y
	mv y.tab.c expr.c
	$(CC) $(CFLAGS) -c expr.c

clean:
	rm -f *.o *~ $(PROG)
