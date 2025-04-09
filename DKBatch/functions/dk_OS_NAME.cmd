@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# dk_OS_NAME()
::#
::#
:dk_OS_NAME
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=1* delims==" %%A in ('wmic os get Caption /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A"=="Caption" set "OS_NAME=%%S"
	))
	
	endlocal & (
		set "OS_NAME=%OS_NAME%"
	)
)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_OS_NAME
	echo OS_NAME = '%OS_NAME%'
%endfunction%
