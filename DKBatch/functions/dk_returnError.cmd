@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::################################################################################
::dk_returnError()
::#
:dk_returnError
	endlocal & set LAST_ERROR=%~1
exit /b 1
