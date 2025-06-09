@echo off
set /p shebang=< %USERPROFILE:\=/%/DigitalKnob/Development/DKBash/functions/dk_debug.sh
echo shebang = %shebang%

set /p shebang=< %USERPROFILE:\=/%/DigitalKnob/Development/DKCMake/functions/dk_debug.cmake
echo shebang = %shebang%

pause