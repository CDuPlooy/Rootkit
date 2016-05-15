compile:
	nasm -f elf64 helloWorld.asm -o helloWorld.o -ggdb
	ld helloWorld.o -o helloWorld
debug: compile
	gdb ./helloWorld
