; shebang

; main.asm
;
;   $ nasm -fwin64 -o test.o test.asm
;   $ x86_64-w64-mingw32-gcc -s -o test test.o   # Using MINGW-64 from Linux...
;   C:\work> gcc -s -o test.exe test.o           # ...or, using MINGW-64 from Windows.
;
  bits 64
  default rel    ; x86-64 mode uses RIP relative addressing.

  ; .rdata segment (windows) is a section for read-only data.
  section .rdata

  ; NASM allows escape codes with strings delimited by `.
string:  db `Hello, world!\n`,0

  section .text

  extern printf   ; imported from MSVCRT.DLL.

  global main

  align 4
main:
  ; As per MS-ABI, RSP must be DQWORD aligned before a call
  ; The return address is misaligned by DQWORD, so we must
  ; subtract 8:
  sub   rsp,8

  ; Some functions use a "shadow area" (to store RCX, RDX, R8 and R9).
  ; This area has 32 bytes in size (4 QWORDs). 32 bytes + 8 bytes
  ; will keep RSP DQWORD aligned, so it is common to add 40 to RSP. But,
  ; since we don't need a shadow area, adding 8 to keep RSP aligned is
  ; sufficient.

  ; the MS-ABI uses RCX, RDX, R8 and R9 as the first 4 arguments.
  ; EAX is the # of XMM registers used as arguments.
  xor   eax,eax
  lea   rcx,[string]    ; this is a RIP relative effective address,
                        ; since 'default rel' was used.
  call  printf

  xor   rax,rax

  add   rsp,8
  ret
  