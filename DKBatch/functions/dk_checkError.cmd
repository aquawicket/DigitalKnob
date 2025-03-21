@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_checkError()
::#
:dk_checkError
setlocal
	%dk_call% dk_debugFunc 0

	if %ERRORLEVEL% equ 0 %return%
	%dk_call% dk_error "ERRORLEVEL = %ERRORLEVEL%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_checkError
%endfunction%
