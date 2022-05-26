%.o: %.s
	nasm -g -O1 -f elf -o $@ $<

all: task2b

task2b: task2b.o printer.o flagw.o flagws.o utoa_s.o
	ld  -melf_i386 -o $@ $^

clean:
	rm -f *.o task2b
