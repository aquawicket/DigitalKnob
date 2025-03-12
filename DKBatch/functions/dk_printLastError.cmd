@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::################################################################################
::dk_printLastError()
::#
:dk_printLastError
	echo %red%LAST_ERROR = %LAST_ERROR%%clr%
exit /b 0
