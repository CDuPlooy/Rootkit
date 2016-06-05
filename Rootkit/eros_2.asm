BITS 16
ORG 0x7E00
;;Program
mov esi,stageTwoMsg
call print
call hang

;;Functions

err:
mov esi,errMsg
call print
ret

succ:
mov esi,succMsg
call print
ret


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
hang:
       JMP $

stageTwoMsg: db "Stage two loaded!" , 0xA , 0xD,0
errMsg: db "An Error Occured",0xA,0xD,0
succMsg: db "Execution Normal",0xA,0xD,0
