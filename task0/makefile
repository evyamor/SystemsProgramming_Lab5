all: prog

progas.o: prog.s
	nasm -f elf32 prog.s -o progas.o

prog.o:prog.c
	gcc -m32 -c -o prog.o prog.c		

prog: prog.o progas.o
	gcc -m32 -o prog prog.o progas.o
	
.PHONY: clean
clean:
	rm -rf ./*.o prog
	