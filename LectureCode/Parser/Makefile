all:
	bison -y -d -o calc.y.c calc.y
	flex -ocalc.lex.c calc.lex
	gcc -o calc calc.y.c calc.lex.c -ly -lfl

clean:
	rm -Rf calc.lex.c calc.y.c calc.y.h calc *~
