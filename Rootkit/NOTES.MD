## *Just a little todo list.*
* Set up the stack.
* Write a function to calculate the amount of digits in an integer.
   <br />We need this to be able to convert an integer to a string.
* Look at the FPU and functions using it. You'll need it.
```nasm
dd number1: 0
finit ;;resets FPU registers
mov eax,dword num1 ;; Operating on dword [num1] results in a crash.
mov ebx,dword num2
fld dword [eax] ;;loads 968 onto the fpu stack
fld dword [ebx] ;;fyl2x now computes 1 * log2(968)
fyl2x
```
* FPU needs a lot of memory ; Switch to 32 bit mode first.
* Logarithm rules ; Fuckem right? Well you need them now. Study study study.
* Study the NTFS , FAT and EXT filesystems. Need to read/write.

## *Restructuring the repository.*
* The bootloader now needs to be split into stages.
* Stage one simply loads stage two from where we put the processor into protected        mode.
* Once in protected mode normal execution can proceed. This is where we'll need to <br /> be able to read the different filesystems.
