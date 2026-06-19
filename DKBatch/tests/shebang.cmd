#!C:\Windows\System32\cmd.exe 2>nul
@echo off



set /p shebang=< %USERPROFILE:\=/%/Digital Knob/Development/DKBash/functions/dk_debug.sh
echo shebang = %shebang%

set /p shebang=< %USERPROFILE:\=/%/Digital Knob/Development/DKCMake/functions/dk_debug.cmake
echo shebang = %shebang%

set /p shebang=< %~f0
echo shebang = %shebang%

pause