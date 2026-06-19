; shebang

BITS 64

extern __getmainargs
extern _exit
extern atoi
extern printf
extern puts
extern CommandLineToArgvW
extern GetCommandLineA

;;symbol import table
;import __getmainargs       msvcrt.dll
;import _exit               msvcrt.dll
;import atoi                msvcrt.dll
;import printf              msvcrt.dll
;import puts                msvcrt.dll
;import CommandLineToArgvW shell32.dll
;import GetCommandLineA   kernel32.dll

;;global var
section .bss
argc resd 1
argv resd 1
envp resd 1

;; like main, but without standrad main c wrap under the hood
section .text use32 
..start: ;; get main args
    pushad
    push 0
    push 0
    push envp
    push argv
    push argc
    call [__getmainargs]
    add esp, 20
    mov ecx, dword [argc]
    cmp ecx,3
    jg Lchallenge
    push aNode
    call [puts]
    add esp, 4    
    xor eax, eax 
    jmp Lend
Lchallenge:
    mov eax, dword [argv]
    dec ecx    
    lea eax,[eax+ ecx*4] ;last argv
    push dword [eax]
    call [atoi]
    add esp, 4    
    lea ebx,[a1202+eax]
    push ebx
    call [puts]
    add esp, 4
    popad
    push dword 2 ;; exit with status 2
    call [_exit]
Lend:    
    popad
    push dword 0 ;; exit with status 0
    call [_exit]
    ret

section .data 
a1202  db "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz", 0
aNode  db "Argc <= 3", 0

section .rodata
fmt db "%d\n",0