:# Check Windows version: minimum requirement Windows
:# 2000, but useful only for Windows XP SP2 and later
if not "%OS%"=="Windows_NT"     goto Err9X
ver | find "Windows NT" >NUL && goto ErrNT


:Err9X
echo Error: Does not work on Windows 9x
goto eof

:ErrNT
>&2 echo Error: Works only on Windows 2000 and later
goto :eof