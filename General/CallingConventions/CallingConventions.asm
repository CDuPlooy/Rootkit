BITS 32
global _start
section .data

section .text
_start:

push dword 1
call cdelc_add
	add ebp , 8	;; When using the cdelc convention the caller has to clean up.

push dword 1
call std_add ;; We don't need to do any kind of clean up.

push dword 1
mov ecx,eax
mov edx,1
call fastcall_add

JMP $ ;; Fall through will occur once example is done, this prevents fall through but the program will hang

cdelc_add:  ;; Cdelc means the caller has to clean up
add eax,[esp + 8] ;; The size of an integer is 8 for 64 bit systems and 4 for 32 bit systems.
ret

std_add: ;; stdcall means the callee has to clean up.
add eax,[esp + 8]
;; Alternatively add esp , 8
ret 8 ;; Cleans up, and then returns.

fastcall_add: ;; First two arguments go onto into ecx,edx and the rest unto the stack. Callee still does cleanup.
add ecx , edx
add ecx , [esp+8]
mov eax,ecx
xor ecx , ecx ;; Quick way to zero a register
ret 8
ret
