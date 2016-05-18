compile:clean
	nasm -f elf64 stack.asm -o stack.o -ggdb
	ld stack.o -o stack
	rm stack.o -f
clean:
	rm stack.o -f


debug: compile
	gdb stack
