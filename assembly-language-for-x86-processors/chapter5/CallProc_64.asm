; Calling a subroutine in 64-bit mode (CallProc_64.asm)
; Chapter 5 example

ExitProcess PROTO
WriteInt64 PROTO      ; Irvine64 library
Crlf PROTO            ; Irvine64 library

.code
  main PROC
    sub  rsp, 8       ; align the stack pointer
    sub  rsp, 20h     ; reserve 32 bytes for shadow params

    mov  rcx, 1       ; pass four parameters, in order
    mov  rdx, 2
    mov  r8, 3
    mov  r9, 4
    call AddFour      ; look for return value in RAX
    call WriteInt64   ; display the number
    call Crlf         ; output a CR/LF

    mov  ecx, 0
    call ExitProcess
  main ENDP

  AddFour PROC
    mov rax, rcx
    add rax, rdx
    add rax, r8
    add rax, r9
    ret
  AddFour ENDP

  END