setlocal enabledelayedexpansion
set "hex=5A"
echo !hex!> temp.hex
call certutil -decodehex temp.hex str.txt >nul
set /p str=<str.txt
echo:
( del temp.hex & del str.txt )>nul
echo Your decoded string is:"!str!".
endlocal
pause
exit /b 0
