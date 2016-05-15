BITS 16
ORG  0x7C00

section .text

xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
xor esi,esi

mov esi, msg
call print

JMP $ ;; HANG


printChar:
      mov ah,0x0e
      mov bh,0x0
      mov bl,0x07
      int 0x10
      ret

print:
      mov al,[si]
      inc esi
      or al,al
      JZ print_done
      call printChar
      JMP print
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
      ret
;;I forgot that the message for some reason needs to be down here. I Never really figured out why.
msg db "Eros Rootkit" , 0xA , 0x10 , "Debug Version",0
 TIMES 510 - ($ - $$) db 0 ;;zero fills the remaining space
 DW 0xAA55 ;;Signature for the BIOS
