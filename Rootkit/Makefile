compile:
	nasm -f elf64 eros.asm -o helloWorld.o -ggdb
	ld eros.o -o eros
debug: compile
	gdb ./eros
