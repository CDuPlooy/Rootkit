## *Just a little todo list.*
* Set up the stack.
* Write a function to calculate the amount of digits in an integer.
   <br />We need this to be able to convert an integer to a string.
* Look at the FPU and functions using it. You'll need it.
```nasm
dd number1: 0
finit                                                                   ;;resets FPU registers
mov eax,dword num1                                       ;; Move pointers into registers first
mov ebx,dword num2
fld dword [eax]                                                  ;;loads the value eax is point to
fld dword [ebx]                                                  ;;fyl2x now computes y * log2(x)
fyl2x
```
* Logarithm rules ; Fuckem right? Well you need them now. Study study study.
* Study the NTFS , FAT and EXT filesystems. Need to read/write.

## *Restructuring the repository.*
* The bootloader now needs to be split into stages.
* Stage one simply loads stage two from where we put the processor into protected        mode.
* Once in protected mode normal execution can proceed. This is where we'll need to <br /> be able to read the different filesystems.


## What I've Learned So Far:#
* Assembly takes a lot of work.
* The FPU doesn't need a lot of memory , it should work fine in 16 bit mode. ( Not 100% Sure But At Least A Tiny Bit Certain )
* BIOS functions uses the stack ( SUPRISE! ) so I should probably set it up first.
* The read BIOS call only loads 512 blocks at a time. meaning stage 2 shouldn't exceed 512 bytes. At least not yet.

## Related Links
* [uefi-example](http://forum.nasm.us/index.php?topic=2191.0)
