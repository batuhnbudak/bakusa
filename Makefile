LEX = lex
YACC = yacc -d

CC = gcc


all: parser clean

parser: y.tab.o lex.yy.o
	$(CC) -o parser y.tab.o lex.yy.o
	./parser < test.txt


lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: y.tab.c


y.tab.c y.tab.h: CS315f20_team16.y
	$(YACC) -v CS315f20_team16.y


lex.yy.c: CS315f20_team16.l
	$(LEX) CS315f20_team16.l

clean:
	-rm -f *.o lex.yy.c *.tab.* parser *.output
