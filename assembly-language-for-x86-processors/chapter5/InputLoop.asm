; Library Test #1: Integer I/O (InputLoop.asm)

; Tests the Clrscr, Crlf, DumpMem, ReadInt, SetTextColor
; WaitMsg, WriteBin, WriteHex, and WriteString procedures.
INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096

.data
  COUNT = 4
  BlueTextOnGray = blue + (lightGray * 16)
  DefaultColor = lightGray + (black * 16)
  arrayD SDWORD 12345678h, 1A4B2000h, 3434h, 7AB9h
  prompt BYTE "Enter a 32-bit signed integer: ", 0
.code
  main PROC
    mov  eax, BlueTextOnGray
    call SetTextColor
    call Clrscr                 ; clear the screen
    mov  esi, OFFSET arrayD
    mov  ebx, TYPE arrayD       ; doubleword = 4 bytes
    mov  ecx, LENGTHOF arrayD   ; number of units in arrayD
    call DumpMem                ; display memory
    call Crlf
    mov  ecx, COUNT
    L1:  mov edx, OFFSET prompt
         call WriteString
         call ReadInt           ; input integer into EAX
         call Crlf              ; display a newline
         call WriteInt          ; display in signed decimal
         call Crlf
         call WriteHex          ; display in hexadecimal
         call Crlf
         call WriteBin          ; display in binary
         call Crlf
         call Crlf
         Loop L1                ; repeat the loop
         call WaitMsg           ; "Press any key..."
         mov  eax, DefaultColor
         call SetTextColor
         call Clrscr
         exit
  main ENDP
  END main