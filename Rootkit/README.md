# General Notes:
* When compiling on linux dd is the most useful. See the compiling section.
* With assembly you usually have to play  around with the code to get it to work ; Be patient.


## 1 - Compiling ( Hardware method ):
* Compile with make
* Check what device is your target drive with lsblk. Usually it is the last one.
* sudo dd if=eros_final.raw of=/dev/sdb bs=512


The third step is the most important because we want the bootloader to be located at the<br />
first block on the device. BIOS looks at these blocks to determine if a device is bootable.<br />Later when the stage II bootloader is finished we will compile differently ; Skipping over <br />the first 512 bytes so that the second part is easy to load from within the first.


## 2 - Compiling ( Software method ):
* Make sure that you have qemu installed.
* make qemu
