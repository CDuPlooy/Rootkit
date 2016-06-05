compile_raw:
	nasm -f bin eros.asm -o eros.raw
	nasm -f bin eros_2.asm -o eros_2.raw
	@cat eros.raw > eros_final.raw
	@cat eros_2.raw >> eros_final.raw
	@echo "Generating eros_final"
	@rm eros.raw
	@rm eros_2.raw
	@echo "Cleaning up"
qemu: compile_raw
	qemu-system-i386 -fda eros_final.raw -boot a
clean:
	rm eros.raw
#A useless comment
