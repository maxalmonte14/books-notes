# Programming From The Ground Up

The book *Programming From The Ground Up* can be accessed completely free and legally [here](https://download-mirror.savannah.gnu.org/releases/pgubook/ProgrammingGroundUp-1-0-booksize.pdf).

## Chapter 2 - Computer Architecture

#### Pag 7

Modern computers used the Von Newman architecture, which divides the computer into CPU and memory

#### Pag 9

The CPU reads instructions from memory one at a time. This is known as the fetch-execution cycle

The elements of the CPU are: Program Counter, Instruction Decoder, Data Bus, General-purpose Registers, and Arithmetic and Logic Unit

#### Pag 9-10

The ***Program Counter*** is used to tell the computer where to fetch the next instruction from. It holds the memory address of the next instruction to be executed.

It is then passed to the ***Instruction Decoder*** which figures out what the instruction mean. This includes what process needs to take place and what memory locations are going to be involved in this process.

At this point the ***Data Bus*** will fetch the memory locations to be used in the calculation. The Data Bus is the connection between the memory and the CPU, literally, the CPU and the memory are connected in a motherboard, that's the actual data bus.

Now, data is brought from memory into ***Registers*** (a special high-speed memory built into the CPU), procesed, and then put back into memory again.

There are two types of ***Registers***, ***General-purpose Registers***, and ***Special-purpose Registers***. 

***General-purpose Registers*** take care of operations such as addition, subtraction, multiplication, and comparisson (***Special-purpose Registers*** are not important at the moment).

Finally the data is passed to the ***Arithmetic and Logic Unit*** where data is further processed, executed, and eventually put back into the given bus and sent to the right memory address or register.

The ***fetch-execute*** cycle works as follows:

Program Counter > Instruction Decoder > Data Bus > (General Purpose) Registers > Arithmetic and Logic Unit

#### Pag 11

The size of a single memory storage location is a byte, in x86 architecture that's a number between 0 and 255.

#### Pag 12

In x86 architecture registers are 4 bytes long each, the size of a Register is know as a computer's word, so in x86 CPUs we have 4 byte words. Memory addresses are also 4 bytes long (1 word), so they can fit in a Register. Addresses that are stored in memory are called pointers, because instead of having a regular value in them they point you to a different location in memory.

#### Pag 13

A Special-Purpose Register called the Instruction Pointer manages pointers

#### Pag 15-16

Processors have different ways of accessing data, including: Immediate Mode, Register Addressing Mode, Direct Addressing Mode, Indexed Addressing Mode, and Base Pointer Addressing Mode.

- **Immediate Mode**: if we want to initialize a register to 0, instead of giving the computer an address to read the 0 from, we would specify Immediate Mode, and give it the number 0.
- **Register Addressing Mode**: in this mode the register contains a register to access rather than a memory location.
- Direct Addressing Mode: the instruction contains the memory address to access
- **Indexed Addressing Mode**: the instruction contains a memory address to access, and also specifies an index register to offset that address. For example if the addresss is 2002 and the index is 4, the address loaded will be 2006. On x86 processors you can also specify a multiplier for the index
- **Indirect Addressing Mode**: the instruction constains a register that contains a pointer to where the data should be accessed. It goes from register, to pointer, to memory address, to value
- **Base Pointer Addressing Mode**: similar to Indirect Addressing Mode, but you also include an offset to add to the register's value before using it for lookup

## Chapter 3 - Your First Programs

#### Page 20-21

To turn a source code Assembly file into a program it must first be *assembled* and *linked* it.

***Assembling*** is the process that transform what we wrote into instructions for the machine.

To *assemble* the file [exit.s](./chapter3/exit.s) the following command must be run:

```bash
as exit.s -o exit.o
```

**Note:** this assumes a Linux machine is being used, and the package `binutils` is installed.

`exit.o` is what is known as an object file, which is code that is in the machine's language, but has not been completely put together.

The ***linker*** is the program that is responsible for putting the object files together and adding information so the kernel knows how to load and run it.

To *link* the file [exit.o](./chapter3/exit.o) the following command must be run:

```bash
ld exit.o -o exit
```

#### Page 23-28

Anything starting with a period (in our `exit.s` file would be `.section .data`, `.section .text`, and ` .globl _start`) is not translated into a machine instruction but used by the assembler itself. These are called ***Assembler directives*** or ***Pseudo-operations***.

`.section .data` starts the data section, where any memory storage needed for data is usually listed.

`.section .text` is where the program instructions live.

`.globl _start` defines a ***symbol*** called `_start`. *Symbols* are generally used to mark locations of programs or data, so you can refer to them by name instead of by their location number.

`.globl` means that the *assembler* should not discard the following symbol after *assembly* because the *linker* will need it. `_start` is a special symbol that always need to be marked with `.globl` because it marks the location of the start of the program.

`_start:` defines the value of the `_start` ***label***. A ***label*** is a *symbol* followed by a colon. *Labels* define a *symbol*'s value.

`movl $1, %eax` this instruction moves the number `1` to the `%eax` register. The instruction `movl` has two operands, the *source* and the *destination*. In this case the *source* is the literal number `1` and the *destination* is the `%eax` register. Operands can be numbers, memory location references, or registers. The dollar-sign in front of the one (`1`) indicates we want to use *immediate mode addressing*, without it, it would do *direct addressing*, loading whatever number is at address `1`.

The number `1` has to be moved to `%eax` because we are preparing to call the Linux kernel, and number `1` represents the `exit` *system call*.

For the `exit` *system call* the operating system requires a status code to be loaded in `%ebx`.

`movl $0, %ebx` moves the literal value `0` to the `%ebx` register (similar to what `movl $1, %eax` does).

`int $0x80`, the `int` stands for ***interrupt***. The `0x80` is the interrupt number to use (the `0x` prefix indicates this is a hexadecimal number). An *interrupt* interrupts the normal program flow and transfers control to Linux so that will do a system call.

#### Page 31-40

**Note**: In this section we explain the program [maximum.s](./chapter3/maximum.s).

```assembly
data_items:
    .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0
```

This line defines a label (`data_items`), then we have the directive `.long` that reseves 4 bytes for each one of the numbers that follow it.

Other directives to reserve different size memory locations:

- `.byte`: takes a number between 0 and 255
- `.int`: not to be confused with the `int` instruction! Takes a number from 0 to 65535 (2 bytes)
- `.long`: takes a number between 0 and 4294967295 (4 bytes, the same space as a register)
- `.ascii`: used to represent characters in memory. Each character takes 1 byte, and a `\0` represents a termination character (end of the string). Other special characters like `\n` and `\t` are also supported

`movl $0, %edi` sets the current index at `0`, since `0` represents the first element of our list of *long*s.

`movl data_items(,%edi,4), %eax`, in this line we are using *Indexed Addressing Mode*, we are asking our program to begin at the address associated with the label `data_items`, take the item at index `0` (because %edi at the moment is `0`), which occupies 4 bytes. We take that value and put it in the register `%eax`, thus saving the first number of our list (`3`) as the highest number so far (because is the only one we have seen) in register `%eax`.

```assembly
cmpl $0, %eax
je loop_exit
```

In these two lines we start by comparing the value `0` to whatever the value in `%eax` is (`cmpl` stands for *compare long*). Then we jump to the label `loop_exit` if the values are equal (`je` stands for *jump equal*) which means we reached the end of the list. The result of the comparison is stored in the `%eflags` register, which is known as the ***status register***.

Other comparisson instructions:

- `jg`: jump if the second value is greater than the first one
- `jge`: jump if the second value is greater than or equal the first one
- `jl`: jump if the second value is less than the first one
- `jle`: jump if the second value is less than or equal the first one
- `jmp`: jump no matter what. It dos not need to be preceeded by a comparison

```assembly
incl %edi
movl data_items(,%edi,4), %eax
```

`incl %edi` (*increment long*) increments the value stored in `%edi` (our current index) by `1`. Then the next line takes the current number in the list and puts it in `%eax` as seen before.

```assembly
cmpl %ebx, %eax
jle start_loop
```

In here we compare if the current value (`%eax`) is less than or equal to our max value (`%ebx`) and if it is we jump to `start_loop`.

```assembly
movl %eax, %ebx
jmp start_loop
```

If the last comparisson didn't trigger a jump to `start_loop` it means our current value (stored in `%eax`) is greater than our max value (stored in `%ebx`), which means `%ebx` has to be updated, what we do, and then jump to `start_loop`.

#### Page 42-43

**Note**: This section covers how to actually use the different addressing modes.

***Direct Addressing Mode*** as the name implies, in this mode we directly use the memory address. In the following example we are copying the value in `ADDRESS` to `%eax`:

```assembly
movl ADDRESS, %eax
```

***Indirect Addressing Mode*** loads a value from the address indicated by a register and we can use it as illustrated next:

```assembly
movl (%eax), %ebx
```

***Base-pointer Addressing Mode*** is similar to *Indirect Addressing Mode*, except it adds a constant value to the address in the register. For example, the following example takes the memory address in `%eax` (let's say `1000`) and adds 4 bytes (turning it into `1004`):

```assembly
movl 4(%eax), %ebx
```

#### Page 44

**Note**: This section covers how to operate at different levels besides the word level (4 bytes at a time).

The instruction `movb` will move 1 byte instead of 4 at a time.

The register `%ax` represents the least-significant half (last two bytes) of the register `%eax`, it can be use to do operations 2 bytes at a time. `%ax` is divided into `%al` and `%ah`, `%al` being the least-significant byte of `%ax` and `%ah` being the most-significant byte. Think `l` for low priority and `h` for high priority. Since all these registers are related (`%eax`, `%ax`, `%ah` and `%al`) operating in one will change the values in the others, so **be cautious**.

## Chapter 4 - All About Functions

#### Page 53-58

The register `%esp` contains a pointer to the current top of the ***stack*** (reminder: the stack is a region in memory that works, precisely, as a stack or LIFO data structure). The actual stack in memory starts at the top of the memory and grows downward, this is due to architectural considerations.

A value can be pushed to the top of the stack with the instruction `pushl`, and popped with `popl`. When we push a value to the top of the stack `%esp` gets subtracted by `4` (if it was previously `1000` then it becomes `996`), popping adds `4` to `%esp`. 

Besides `pushl` and `popl` we can use the different addressing modes to access it, without modifying it. For example, accessing the top of the stack without popping it by using *Indirect Addressing Mode*:

```assembly
movl (%esp), %eax
```

Or accessing the value just below the top of the stack by using *Base-pointer Addressing Mode*:

```assembly
movl 4(%esp), %eax
```

In the C language calling convention (which we are going to use here), the stack is the key element for
implementing a function's local variables, parameters, and return address.

Before executing a function, a program pushes all of the parameters for the function onto the stack in the reverse order that they are documented (i.e. `param3`, `param2`, `param1` instead of `param1`, `param2`, `param3`). Then the program issues a call instruction indicating which function it wishes to start. The call instruction does two things. First it pushes the address of the next instruction, which is the return address, onto the stack. Then it modifies the instruction pointer (%eip) to point to the start of the function. This is better represented visually in the next following:

```
Parameter #N
...
Parameter 2
Parameter 1
Return Address <--- (%esp)
```

**Note**: the "top" of the stack is represented at the bottom in that last example.

The first thing to do in a function is save the current ***base pointer*** `%ebp` by calling `pushl %ebp`. The base pointer is a special register used for accessing function parameters and local variables. Next, we have to copy the stack pointer to `%ebp` by doing `movl %esp, %ebp`. This help us access the function parameters as fixed indexes from the base pointer instead of the stack, since this can be changed at any point.


`%ebp` represents now the state of the stack at the moment of calling our function, or our ***stack frame***. So far the stack looks like follows:

```
Parameter #N    <--- N*4+4(%ebp)
...
Parameter 2     <--- 12(%ebp)
Parameter 1     <--- 8(%ebp)
Return Address  <--- 4(%ebp)
Old %ebp        <--- (%esp) and (%ebp)
```

As you can see, each parameter can be accessed using base pointer addressing mode using the `%ebp` register.

The next thing to do is to reserve space on the stack for any local variables we plan on using, for example, assuming we are going to use `2` local variables we can reserve `8` bytes by subtracting `8` to the top of the stack:

```assembly
subl $8, %esp
```

It is important to note that when we return, the stack frame will go away, disposing of our variables.

With this in mind the stack will look like this:

```
Parameter #N      <--- N*4+4(%ebp)
...
Parameter 2       <--- 12(%ebp)
Parameter 1       <--- 8(%ebp)
Return Address    <--- 4(%ebp)
Old %ebp          <--- (%ebp)
Local Variable 1  <--- -4(%ebp)
Local Variable 1  <--- -8(%ebp) and (%esp)
```

When a function is done executing it does these 3 things:

1. It stores its return value in `%eax`
2. It resets the stack to what it was when it was called (it gets rid of the current stack frame and puts the stack frame of the calling code back into effect)
3. It returns control back to wherever it was called from. This is done using the `ret` instruction, which pops whatever value is at the top of the stack, and sets the instruction pointer, `%eip` to that value.

Before a function returns, it must restore the stack to the state it was before the function was called. The instruction `ret` will not work unless we do this because is expecting our return address to be at the top of the stack. Therefore, before returning we have to reset the *stack pointer* (`%esp`) and *base pointer* (`%ebp`) to what they were when the function began. We can achieve that by doing the following:

```assembly
movl %ebp, %esp
popl %ebp
ret
```

At this point we should consider all local variables to be disposed of. Technically they still exist in memory (or so I understand) but since we moved the stack pointer back, future pushes will overwrite those values, so we shouldn't rely on them.

Control has now beenhanded back to the calling code, which can now examine `%eax` for the return value. The calling code also needs to pop off all of the parameters it pushed onto the stack in order to get the stack pointer back where it was. One could also simply add `4 * number of paramters` to `%esp` using the `addl` instruction, if the values of the parameters aren't needed anymore.

#### Page 62-63

**Note**: In this section we explain the program [power.s](./chapter4/power.s).

**Note**: this book assumes we are working on a 32 bit CPU, if that is not the case the flag `--32` must be passed when *assembling* a file like so: `as power.s -o power.o --32`. Meanwhile when *linking* we should add the following `-m elf_i386` to the linker command, like this: `ld -m elf_i386 power.o -o power`.

```assembly
.type power,@function
```

This line instructs the linker to use the symbol `power` as a function.

```assembly
power:
  pushl %ebp
  movl  %esp, %ebp
  subl  $4, %esp
```

At this point, our stack looks like this:

```
Base Number     <---  12(%ebp)
Power           <---  8(%ebp)
Return Address  <---  4(%ebp)
Old %ebp        <---  (%ebp)
Current result  <---  -4(%ebp) and (%esp)
```

The instruction `imull` does integer multiplication and stores the result in the second operand, while `decl` decreases the given register by `1`.

#### Page 66-71

**Note**: In this section we explain the program [factorial.s](./chapter4/factorial.s).

```assembly
_start:
  pushl $4
  call  factorial
```

Since the program is supposed to compute the factorial of `4` we start by pushing `4` (if could have been any number) to the top of the stack. Then we call the `factorial` function.

```assembly
addl $4, %esp
movl %eax, %ebx
movl $1, %eax
int $0x80
```

In this last snippet the line `addl $4, %esp` restore the stack to where it was before calling the `factorial` function. Remember that the stack works from top to bottom, so by calling `addl` we are freeing space, `subl` on the other hand would reserve space. Next we are taking the return value of the function (`%eax`), moving it to `%ebx`, which expects the program exit's status, and then we do a stardard system call.

```assembly
.type factorial, @function
factorial:
  pushl %ebp
  movl  %esp, %ebp
```

As seen before, these lines define a function and point `%esp` to the top of the stack.

```assembly
movl 8(%ebp), %eax
```

In here we *base pointer addressing* to move (actually copy) the first parameter of the function into `%eax`. How come the first parameter is in `8(%ebp)`? Here's an explanation:

- `(%ebp)` has the old `(%ebp)`
- `4(%ebp)` has the return address
- `8(%ebp)` is the location of the first (and only) parameter of the function

```assembly
cmpl $1, %eax
je   end_factorial
```

Then we check if `%eax` is equal to `1`, if so, we jump to the label `end_factorial`.

```assembly
decl  %eax
pushl %eax
call  factorial
```

If `%eax` is not equal to `1` we decrease it by `1`, push it to the stack, and call `factorial` again.

```assembly
movl 8(%ebp), %ebx
imull %ebx, %eax
```

What these lines do was a little obscure to me at first, then I understood their purpose. An explanation:

After calling a function we lose control of the registers, they could be holding any value, or none at all, except `%esp` and `%ebp` of course. So after calling the function `factorial` with the number `4` and this calling itself with the number `3` we should resume execution after `factorial` has called itself with number `3`, `2` and `1`, that's `3!`, which equals `9`, and since `4!` is equal to `4 * 3!`, we put the original parameter (`4`) into a temporary variable with `movl 8(%ebp), %ebx`, and multiply this variable with the result of the second call to `factorial` (`%eax`) as in `imull %ebx, %eax`. Now `%eax` holds the value of `4!`.

```assembly
end_factorial:
  movl  %ebp, %esp
  popl  %ebp
  ret
```

Finally we destroy the current stack frame, reactivate the previous one, and return control to the main program.