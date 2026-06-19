; shebang

BITS 64

; Assembly with NASM for 64-bit
; nasm -f win64 -o messagebox.o messagebox.asm

; Linking for 64-bit with MinGW
; x86_64-w64-mingw32-ld -o messagebox.exe messagebox.o -lkernel32 -luser32

extern MessageBoxA
extern ExitProcess
section .data
    title db 'dk_messageBox', 0
    content db 'test dk_messageBox', 0

section .text
global main

	
main:
    xor rcx, rcx            ; hWnd = NULL
    lea rdx, [rel content]  ; lpText
    lea r8,  [rel title]    ; lpCaption
    mov r9d, 0              ; uType = MB_OK (0)  ; use 0 or 0x00000040 etc

    ; call MessageBoxA  (RSP is assumed aligned here)
    sub rsp, 40             ; shadow space (allocate 32 + align) — safe
    call MessageBoxA
    add rsp, 40

    xor ecx, ecx            ; uExitCode = 0 (zero-extends to rcx)
    call ExitProcess