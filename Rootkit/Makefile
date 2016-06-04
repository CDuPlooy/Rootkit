compile_raw:
	nasm -f bin eros.asm -o eros.raw
qemu: compile_raw
	qemu-system-i386 -fda eros.raw -boot a
clean:
	rm eros.raw
#A useless comment
