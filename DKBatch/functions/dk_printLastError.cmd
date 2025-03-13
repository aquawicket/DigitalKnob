@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::################################################################################
::# dk_printLastError()
::#
:dk_printLastError
	if ERRORLEVEL 1 (echo %red%ERRORLEVEL = '%ERRORLEVEL%'%clr%)
	if NOT ERRORLEVEL 0 (echo %red%ERRORLEVEL = '%ERRORLEVEL%'%clr%)
	echo %red%LAST_ERROR = %LAST_ERROR_STATUS%: '%LAST_ERROR%'%clr%
%endfunction%
