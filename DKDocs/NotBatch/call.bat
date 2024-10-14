rem Support code for "CALL command" in a text file redirected to cmd.exe

rem Get and store the return (current) offset
FilePointer 0 0 /C
set EOF=%errorlevel%

rem Set the offset to jump to the :subroutine
setlocal EnableDelayedExpansion
set "sub=%1"
FilePointer 0 !%sub:~1%!

rem Get and store the parameters
set params=%*
for /F "delims=" %%a in ("!params:*%1=!") do endlocal & set params=%%a