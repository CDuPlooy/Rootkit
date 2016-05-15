BITS 32
 section .data
msg db "Hello World!",10,0
 section .bss

section .text
global _start

_start:
xor ebx,ebx
mov eax,msg
call len
;;eax now contains the length of the string
mov ebx,eax
mov eax,msg
call print

mov eax,1
mov ebx,0
int 0x80

ret
;expects eax to be a string
;expects ebx to be the string length
;recall that int 0x80 calls a system call
;we'll be using write for this example
print:
mov ecx,eax
mov eax,4 ;;write
mov edx,ebx
mov ebx,1 ;;stdout
int 0x80
ret


;eax should be the string
;eax will be the result , using ebx
len:
      xor ebx , ebx
len_loop:
      cmp byte [eax],0
      JE len_done
      add eax,1
      add ebx,1
      JMP len_loop
len_done:
      mov eax , ebx
      xor ebx,ebx
      ret
