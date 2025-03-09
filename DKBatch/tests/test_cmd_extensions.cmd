@echo off
::setlocal EnableExtensions
::setlocal DisableExtensions


if "~x0"=="%~x0" goto :NOCMDEXT 
if "%%~x0"=="%~x0" goto :NOCMDEXT
if CmdExtVersion 2 goto :CMDEXTV2
goto :CMDEXTV1
pause

:CMDEXTV1
echo Command extensions v1 available
pause
goto :EOF

:CMDEXTV2
echo Command extensions v2 or later available
pause
exit /b 0

:NOCMDEXT
echo Command extensions not available
pause
:: END OF FILE

