# Code That Didn't Work:

Definitely not an error on my part. I came across this after thinking for hours how to write something that proves that the BIOS does use the stack ( just in case your a paranoid chap who won't believe anything he reads on the web ).

Consider the following code that sets up the stack ( line 1 is the problem ):
```assembly
_stackCreation:
        mov ax,0x7C00 ;;------> Changing this to xor eax,eax works. I'm not sure if it's defined to be that way though.
        add ax,512      ;;Size of stage 1
        ;;add ax,598    ;;We'll have a stage 2 as well so uncomment this later
        add ax,8092    ;;Disk buffer.
        add ax,4092 ;;Stack

        ;;set registers
        mov ss,ax
        mov sp,0
```
Adding this to stage 1 of our bootloader results in some interesting behavior. If this code is called as the program starts and a push/pop occurs before the BIOS interrupts are called it will cause the BIOS interrupts to execute strangely.

Instead of getting my normal prompt when booting ; I got:
```
Booting from floppy: ( Qemu says this! :D )
E
```
I'm guessing that by messing up the stack , I messed up some of my variables. I'll confirm this later :) In any case - don't do this ...
