rem Support code for "GOTO command" in a text file redirected to cmd.exe

if %1 equ :EOF (
   rem Jump to last saved return offset
   FilePointer 0 %EOF%
) else (
   rem Jump to a normal label
   setlocal EnableDelayedExpansion
   FilePointer 0 !%1!
)