@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::setlocal EnableExtensions
::setlocal DisableExtensions


if "~x0" equ "%~x0" goto :NOCMDEXT
if "%%~x0" equ "%~x0" goto :NOCMDEXT
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

