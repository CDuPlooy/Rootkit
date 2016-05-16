## *Just a little todo list.*
* Write a function to calculate the amount of digits in an integer.
   <br />We need this to be able to convert an integer to a string.
* Look at the FPU and functions using it. You'll need it.
* Logarithm rules ; Fuckem right? Well you need them now. Study study study.
* Study the NTFS , FAT and EXT filesystems. Need to read/write.

## *Restructuring the repository.*
* The bootloader now needs to be split into stages.
* Stage one simply loads stage two from where we put the processor into protected        mode.
* Once in protected mode normal execution can proceed. This is where we'll need to <br /> be able to read the different filesystems.
