; AddTwoSum_64.asm - Chapter 3 example.

ExitProcess PROTO

.data
  sum DWORD 0

.code
  main PROC
    mov  eax, 5
    add  eax, 6
    mov  sum, eax

    mov  ecx, 0
    call ExitProcess
  main ENDP
  END