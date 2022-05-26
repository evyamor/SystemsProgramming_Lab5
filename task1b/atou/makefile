all: prog

atou_s.o: atou_s.s
	nasm -f elf32 atou_s.s -o atou_s.o

prog.o:prog.c
	gcc -m32 -c -o prog.o prog.c		

prog: prog.o atou_s.o
	gcc -m32 -o prog prog.o atou_s.o
	
.PHONY: clean
clean:
	rm -rf ./*.o prog
	