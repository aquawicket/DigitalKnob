@echo off
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getError()
::#
:dk_getError
	if not "!errorlevel!"=="0" %dk_call% dk_error "!errorlevel! ERROR: in !__FILE__! !___FUNC___![!__ARGV__!]"
rem	(
rem		(goto) 2>nul
rem		exit /b
rem	)  
exit /b 0
