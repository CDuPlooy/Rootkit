BITS 16
ORG  0x7C00

section .text
xor ax, ax
mov ds, ax
mov es, ax  ;;xor es,es results in an error
;;This needs to be done on account of segmentation.

;;On boot the drive being used's identifier is stored in dl.
_stackCreation:
        add ax,512      ;;Size of stage 1
        ;;add ax,598    ;;We'll have a stage 2 as well so uncomment this later
        add ax,8092    ;;Disk buffer.
        add ax,4092 ;;Stack

        ;;fall through to stage 1

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
;;int 13h is low level disk services ; ah = 02h read
;;I'm on the right track 13h 02h isn't an extended function

;;; COPIED FROM http://stackoverflow.com/questions/15497842/read-a-write-a-sector-from-hard-drive-with-int-13h
; read_sectors_16
;
; Reads sectors from disk into memory using BIOS services
;
; input:    dl      = drive
;           ch      = cylinder[7:0]
;           cl[7:6] = cylinder[9:8]
;           dh      = head
;           cl[5:0] = sector (1-63)
;           es:bx  -> destination
;           al      = number of sectors
;
; output:   cf (0 = success, 1 = failure)
mov ah,0x02
mov dl,[Drivenum]
xor dh,dh
mov cl , 2 ;;cylinder 2
mov ch, 0 ;;sector 0
mov  bx, 0x7E00 ;;the starting point for
mov al,1
int 0x13
jmp 0x7E00


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
msg: db "Eros Rootkit" , 0xA , 0xD , 0x10 , "Debug Version",0x11 ,0xA , 0xD ,0
errMsg: db "An Error Occured",0xA,0xD,0
succMsg: db "Execution Normal",0xA,0xD,0
hostDevice: db "Host device checked - working.",0xA,0xD ,0 ,0
Drivenum: db 0
 TIMES 510 - ($ - $$) db 0 ;;zero fills the remaining space
 DW 0xAA55 ;;Signature for the BIOS
