compile:
	nasm -f elf64 CallingConventions.asm -o CallingConventions.o -ggdb
	ld CallingConventions.o -o CallingConventions
debug: compile
	gdb ./CallingConventions
