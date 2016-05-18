# * General Info Regarding The Stack : * #
* The ss register is the base stack pointer.
* The sp register is the stack frame pointer.
* This effectively means that ss is the highest point of your stack while sp will be  <br /> the lowest valid value. See the following example:

```assembly
xor eax,eax                                     ;;Clears eax ; Shorter than mov eax,0
push 50                                           ;;Pushes the value of 50 onto the stack
                                                       ;;This means that sp will shrink with size of an integer.
pop ebx                                         ;;Copy the top ( or bottom in this case ) into ebx. The sp
                                                     ;;The sp register now grow with the size of an integer
```
* The stack is just a way of using memory to implement functions. A function is <br /> called by pushing all it's parameters onto the stack and then lastly pushing <br /> the address of the current instruction. After the function executes the program<br /> continues executing from the last address on the stack.
* There are two types of calling conventions; The cdelc convention and the std<br /> calling convention. Look both up , each are extremely important later on.


## Setting Up The Stack :

When booting into 16 bit mode , nothing itself is working except for the instructions that your processor supports. Everything else is implemented by combining these instructions and other hardware. BIOS calls make use of the stack even though the stack is practically non existent at this stage. The logical ( but not entirely sane ) thing to do is set up the stack yourself.

Other tutorials I've seen make use of constants in the following code which obscures it's meaning - I did however learn that a paragraph consists of 16 bytes! I admit I completely forgot how addition works in assembly so this might be the ugly version of this code.

The following rules apply to the code below:
* Normally using a variable/constant's name as below would result in an operation on the memory address. Assume that variables such as diskBuffer are preprocessor directives ( if nasm even supports those x) )
* stageOneSize = 512 bytes
* diskBuffer = 8092 bytes
* stackSize = 4092 bytes ( According to some obscure post somewhere )

Let's get started.

```assembly
_stackCreation:
        mov eax ,  0x7C00               ;;Where stage one starts
        add eax , stageOneSize
        add eax , diskBuffer

        ;;Up and to this point we are simply skipping over memory.
        ;;Remember that the stack grows downward ? The base pointer
        ;;thus should be the top of the stack

        ;; skip over to the top of the stack.
        add eax , stackSize
        ;;Set ss register to the top of the stack
        mov ss,eax
        mov sp,0
```
