; Testing the ArraySum procedure (TestArraySum.asm)

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data
  array  DWORD 10000h, 20000h, 30000h, 40000h, 50000h
  theSum DWORD ?

.code
  main PROC
    mov  esi, OFFSET array    ; ESI points to array
    mov  ecx, LENGTHOF array  ; ECX = array count
    call ArraySum             ; calculate the sum
    mov  theSum, eax          ; returned in EAX

    INVOKE ExitProcess, 0
  main ENDP
  ;---------------------------------------------------------
  ; ArraySum
  ;
  ; Calculates the sum of an array of 32-bit integers.
  ; Receives: ESI = the array offset
  ;           ECX = number of elements in the array
  ; Returns:  EAX = sum of the array elements
  ;---------------------------------------------------------
  ArraySum PROC
    push esi                  ; save ESI, ECX
    push ecx
    mov  eax, 0               ; set the sum to zero

    L1: add  eax, [esi]       ; add each integer to sum
        add  esi, TYPE DWORD  ; point to next integer
        loop L1               ; repeat for array size
        
        pop  ecx              ; restore ECX, ESI
        pop  esi
        ret                   ; sum is in EAX
  ArraySum ENDP

  END main