# Assembly Language for x86 Processors



## Chapter 1 - Basic Concepts

#### Page 53

###### What Types of Programs Can Be Created Using MASM?

32-bit protected mode programs run under all 32-bit and 64-bit versions of Microsoft Windows. They are usually easier to write and understand than real-mode programs.

#### Page 54-56

###### How Does Assembly Language Relate to Machine Language?

***Machine language*** is a numeric language specifically understood by a computer's processor. All x86 processors understand a common machine language. Assembly language consists of statements written with short mnemonics such as `ADD`, `MOV`, `SUB`, and `CALL`. Assembly language has a one-to-one relationship with machine language: Each assembly language instruction corresponds to a single machine- language instruction.

###### How Do C++ and Java Relate to Assembly Language?

High-level languages have a one-to-many relationship with assembly language and machine language. This means that a single statement in C++, for example, expands into multiple assembly language or machine instructions. The following C++ code carries out two arithmetic operations and assigns the result to a variable. Assume `X` and `Y` are integers:

```cpp
int Y;
int X = (Y + 4) * 3;
```

Following is the equivalent translation to assembly language. The translation requires multiple statements because each assembly language statement corresponds to a single machine instruction:

```assembly
mov  eax, Y    ; move Y to the EAX register
add  eax, 4    ; add 4 to the EAX register
mov  ebx, 3    ; move 3 to the EBX register
imul ebx       ; multiply EAX by EBX
mov  X, eax    ; move EAX to X 
```

***Registers*** are named storage locations in the CPU that hold intermediate results of operations.

#### Page 67

###### Specific Machines

A computer's digital logic hardware represents machine Level 1. Above this is Level 2, called the ***instruction set Architecture (ISA)***. This is the first level at which users can typically write programs, although the programs consist of binary values called ***machine language***.

![Virtual machine levels.](./chapter1/screenshots/fig1-1.png)

#### Page 67-68

###### Instruction Set Architecture (Level 2)

Computer chip manufacturers design into the processor an instruction set to carry out basic operations, such as move, add, or multiply. This set of instructions is also referred to as machine language. Each machine- language instruction is executed either directly by the computer's hardware or by a program embedded in the microprocessor chip called a ***microprogram***.

#### Page 68

###### Assembly Language (Level 3)

Above the ISA level, programming languages provide translation layers to make large-scale software development practical. Assembly language, uses short mnemonics such as `ADD`, `SUB`, and `MOV`, which are easily translated to the ISA level. Assembly language programs are translated (assembled) in their entirety into machine language before they begin to execute.

#### Page 73

###### Binary Integers

A computer stores instructions and data in memory as collections of electronic charges. Representing these entities with numbers requires a system geared to the concepts of on and off. Binary numbers are base `2` numbers in which each binary digit (called a bit) is either `0` or `1`. Bits are numbered sequentially starting at zero on the right side and increasing toward the left. The bit on the left is called the ***most significant bit (MSB)***, and the bit on the right is the ***least significant bit (LSB)***. The MSB and LSB bit numbers of a 16-bit binary number are shown in the following figure:

![The MSB and LSB bit numbers of a 16-bit binary number](./chapter1/screenshots/fig1-2.png)

#### Page 79

###### Integer Storage Sizes

The basic storage unit for all data in an x86 computer is a byte, containing 8 bits. Other storage sizes are ***word*** (2 bytes), ***doubleword*** (4 bytes), and ***quadword*** (8 bytes).

![Number of bits for each size](./chapter1/screenshots/fig1-3.png)

#### Page 83-84

###### Converting Unsigned Hexadecimal to Decimal

Suppose we number the digits in a four-digit hexadecimal integer with subscripts as $D_3D_2D_1D_0$. The following formula calculates the integer's decimal value:

$$
dec = (D_3 * 16^3) + (D_2 * 16^2) + (D_1 * 16^1) + (D_0 * 16^0)
$$

For example, hexadecimal `3BA4` is equal to $(3 * 16^3) + (11 * 16^2) + (10 * 16^1) + (4 * 16^0)$, or decimal `15,268`.

![How to convert the hexadecimal number 3BA4 to decimal](./chapter1/screenshots/fig1-4.png)

#### Page 85-86

###### Converting Unsigned Decimal to Hexadecimal

To convert an unsigned decimal integer to hexadecimal, repeatedly divide the decimal value by `16` and retain each remainder as a hexadecimal digit. For example, to convert `422` to hexadecimal:

```
422 / 16 = 26 (remainder 6)
26 / 16 = 1 (remainder A)
1 / 16 = 0 (remainder 1)
```

The resulting hexadecimal number is assembled from the digits in the remainder column, starting from the last row and working upward to the top row. In our case `1A6`.

#### Page 86

###### Hexadecimal Addition

Let's demonstrate this by adding `6A2` and `49A`. We start from right to left adding `2` to `A` (`2` and `10` in decimal), which is `C` (`12` in decimal). Then `A` and `9` (`10` and `9`), the result is `F3` (`19` in decimal), but since `19` is larger than our base number `16` we take the `3` and carry `1`. Finally we add `6`, `4`, and the `1` we are carrying, which is equal to `B` (`11` in decimal)

```
  6A2
+ 49A
-----
  B3C
```

The decimal counterparts of these numbers are `1698`, `1178`, and `2876` respectively.

#### Page 87

###### Signed Binary Integers

***Signed binary integers*** are positive or negative. For x86 processors, the MSB indicates the sign: `0` is positive and `1` is negative.

![Virtual machine levels.](./chapter1/screenshots/fig1-5.png)

#### Page 87-88

###### Two's-Complement Representation

Negative integers use two's-complement representation, using the mathematical principle that the two's complement of an integer is its additive inverse. (If you add a number to its additive inverse, the sum is zero.)

The two's complement of a binary integer is formed by inverting its bits and adding `1`. Using the 8-bit binary value `00000001`, for example, its two's complement turns out to be `11111111`.

| Starting value                         | 00000001                          |
| -------------------------------------- | --------------------------------- |
| Step 1: Reverse the bits               | 11111110                          |
| Step 2: Add 1 to the value from Step 1 | &nbsp;&nbsp;11111110<br>+00000001 |
| Sum: Two's-complement representation   | 11111111                          |

#### Page 88-89

###### Hexadecimal Two's-Complement

To create the two's complement of a hexadecimal integer, reverse all bits and add `1`. An easy way to reverse the bits of a hexadecimal digit is to subtract the digit from `15`.

```
6A3D --> 95C2 + 1 --> 95C3
95C3 --> 6A3C + 1 --> 6A3D
```

#### Page 89-90

###### Converting Signed Binary to Decimal

To convert a signed binary we have to consider the value of its MSB:

- If the highest bit is a `1`, the number is stored in two's-complement notation. Create its two's complement a second time to get its positive equivalent. Then convert this new number to decimal as if it were an unsigned binary integer.
- If the highest bit is a `0`, you can convert it to decimal as if it were an unsigned binary integer.

Taking `11110000` as an example, these are the steps we would take to convert it to decimal:

| Starting value                         | 11110000                          |
| -------------------------------------- | --------------------------------- |
| Step 1: Reverse the bits               | 00001111                          |
| Step 2: Add 1 to the value from Step 1 | &nbsp;&nbsp;00001111<br>+00000001 |
| Step 3: Create the two's component     | 00010000                          |
| Step 4: Convert to decimal             | 16                                |

Because the original integer was negative, we know that its decimal value is `-16`.

#### Page 91

###### Converting Signed Hexadecimal to Decimal

- If the hexadecimal integer is negative, create its two's complement; otherwise, retain the integer as is.
- Using the integer from the previous step, convert it to decimal. If the original value was negative, attach a minus sign to the beginning of the decimal integer.

You can tell whether a signed hexadecimal integer is positive or negative by inspecting its most significant (highest) digit. If the digit is `>= 8`, the number is negative. For example, `8A20` is negative and `7FD9` is positive.

#### Page 92-94

###### Binary Subtraction

When subtracting binary numbers we have have to remember the rules as seen in the following table:

| - | 0 | 1 |
| - | - | - |
| 0 | 0 | 1 |
| 1 | 1 | 0 |

As we can see `0 - 0 = 0`, `1 - 0 = 1`, and `1 - 1 = 0`, but for `0 - 1` we have to borrow `1` from the digit to the left, making it `10 - 1 = 1`. For example:

```
  01101
- 00111
-------
  00110
```

This subtract `7` from `13`, and the result is effectively `6`.

Another approach to binary subtraction is to reverse the sign of the value being subtracted, and then add the two values. This method requires you to have an extra empty bit to hold the number's sign. Using this method first, we negate `00111` by inverting its bits (`11000`) and adding `1`, producing `11001`. Next, we add the binary values and ignore the carry out of the highest bit:

```
  01101
- 11001
-------
  00110
```

#### Page 95-96

###### Unicode Standard

The ***Unicode*** was created as a universal way of defining characters and symbols. It defines numeric codes (called ***code points***) for characters, symbols, and punctuation used in all major languages, as well as European alphabetic scripts, Middle Eastern right-to-left scripts, and many scripts of Asia. Three transformation formats are used to transform code points into displayable characters called ***Unicode Transformation Format (UTF)***:

- ***UTF-8*** used in HTML, and has the same byte values as ASCII.
- ***UTF-16*** used in environments that balance efficient access to characters with economical use of storage. Recent versions of Microsoft Windows, for example, use UTF-16. Each character is encoded in 16 bits.
- ***UTF-32*** used in environments where space is no concern and fixed-width characters are required. Each character is encoded in 32 bits.

#### Page 97-98

###### ASCII Control Characters

Character codes in the range `0` through `31` are called ***ASCII control characters***. If a program writes these codes to standard output, the control characters will carry out predefined actions.

| ASCII Code<br>(Decimal) | Description                                       |
| ----------------------- | ------------------------------------------------- |
| 8                       | Backspace (moves one column to the left)          |
| 9                       | Horizontal tab (skips forward *n* columns)        |
| 10                      | Line feed (moves to next output line)             |
| 12                      | Form feed (moves to next printer page)            |
| 13                      | Carriage return (moves to leftmost output column) |
| 27                      | Escape character                                  |

#### Page 99-100

###### Binary-Coded Decimal (BCD) Numbers

Decimal values can be stored in two general representations, commonly known as ***packed BCD*** and ***unpacked BCD***. These representations rely on the fact that a decimal digit can be represented by a maximum of `4` binary bits, from `0000` to `1001`.

###### Unpacked BCD

In *unpacked BCD*, one decimal digit is encoded in each binary byte. For example, `1,234,567` can be stored as an array of bytes: `01`, `02`, `03`, `04`, `05`, `06`, `07`, shown here in hexadecimal format. If the high-order digit occurs first in the sequence, we call that ***big-endian*** order (the opposite is called ***little-endian*** order). Numbers in *unpacked BCD* format can be of any arbitrary length and can be easily translated into displayable ASCII characters (by adding `30h`) to each byte. For example, if you add `30h` to the *unpacked BCD* value `07`, the result (`37h`) is the ASCII encoding of the displayable character `7`.

###### Packed BCD

In packed BCD format, two decimal digits are encoded in each binary byte. For example, the value `1,234,567` can be stored as the array of bytes (shown here in hexadecimal) as `01`, `23`, `45`, `67`. Because there are an odd number of digits, the upper `4` bits of the first byte can be all zeros, or they can be used to represent the number's sign.

#### Page 104-110

###### Boolean Expressions

A ***Boolean expression*** involves a Boolean operator and one or more operands. Each *Boolean expression* implies a value of true or false. The set of operators includes the following:

- `NOT`: notated as `¬` or `~` or `'`
- `AND`: notated as `∧` or `•`
- `OR`: notated as `∨` or `+`

The `NOT` operator is unary, and the other operators are binary. The operands of a *Boolean expression* can also be Boolean expressions.

The `AND` operation is often carried out at the bit level in assembly language. In the following example, each bit in `X` is `AND`ed with its corresponding bit in `Y`:

![ANDing the bits of two binary integers.](./chapter1/screenshots/fig1-6.png)

The `OR` operation is often carried out at the bit level. In the following example, each bit in `X` is `OR`ed with its corresponding bit in `Y:

![ORing the bits in two binary integers.](./chapter1/screenshots/fig1-7.png)

***Operator precedence*** rules are used to indicate which operators execute first in expressions involving multiple operators. In a *Boolean expression* involving more than one operator, precedence is important. The `NOT` operator has the highest precedence, followed by `AND` and `OR`. You can use parentheses to force the initial evaluation of an expression.