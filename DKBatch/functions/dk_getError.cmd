@echo off
::if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getError()
::#
:dk_getError
::setlocal

	if not "!errorlevel!"=="0" %dk_call% dk_error "!errorlevel! ERROR: in !__FILE__! !___FUNC___![!__ARGV__!]"
	
	(
		(goto) 2>nul
		exit /b
	)  
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getError !errorlevel!
%endfunction%