BITS 16
ORG  0x7C00

section .text

;;On boot the drive being used's identifier is stored in dl.
_stackCreation:
        mov ax,0x0
        add ax,512      ;;Size of stage 1
        ;;add ax,598    ;;We'll have a stage 2 as well so uncomment this later
        add ax,8092    ;;Disk buffer.
        add ax,4092 ;;Stack

        ;;set registers
        mov ss,ax
        mov sp,0

        push 50
        push 50
        pop ebx
        push 50
        pop ebx
        push 50
        pop ebx
        push 50
        pop ebx
        
        pop ebx

_stageOne:
mov [Drivenum] ,dl

xor eax,eax
xor ebx,ebx
xor ecx,ecx
xor edx,edx
;xor esi,esi

mov esi, msg
call print
int 0x11

call checkDrive

call hang

err:
mov esi,errMsg
call print
ret

succ:
mov esi,succMsg
call print
ret

hang:
        JMP $

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

checkDrive:
        mov ah,0x01
        mov dl,[Drivenum]
        int 0x13
        cmp ah,0
        JE checkDrive_fine
        JMP checkDrive_failed
        checkDrive_failed:
                call err
                ret
        checkDrive_fine:
                mov esi,hostDevice
                call print
                ret

;;I forgot that the message for some reason needs to be down here. I Never really figured out why.
;;AAAAAAH CARRIAGE RETURNS!
msg db "Eros Rootkit" , 0xA , 0xD , 0x10 , "Debug Version",0x11 ,0xA , 0xD ,0
errMsg db "An Error Occured",0xA,0xD,0
succMsg db "Execution Normal",0xA,0xD,0
hostDevice db "Host device checked - working.",0xA,0xD ,0 ,0
Drivenum dd 0
 TIMES 510 - ($ - $$) db 0 ;;zero fills the remaining space
 DW 0xAA55 ;;Signature for the BIOS
