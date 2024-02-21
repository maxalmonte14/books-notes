# Programming from the ground up

The book can be accessed completely free and legally [here](https://download-mirror.savannah.gnu.org/releases/pgubook/ProgrammingGroundUp-1-0-booksize.pdf).

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