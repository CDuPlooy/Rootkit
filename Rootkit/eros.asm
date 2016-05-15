BITS 16
ORG  0x7C00
section .data
msg db "Eros Rootkit",10,"Debug Version",0
section .text

mov eax,msg
call len
mov ecx,eax
mov ebx,msg
call print

JMP $ ;; HANG

print:
xor edx,edx
print_loop:
mov al ,byte [ebx]
mov ah , 0x0e
int 0x10

;;
;;read for debug
;;
add edx,1
add ebx,1
cmp ecx,edx
JE print_done
JMP print_loop
print_done:
ret

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

 TIMES 510 - ($ - $$) db 0 ;;zero fills the remaining space
 DW 0xAA55 ;;Signature for the BIOS
