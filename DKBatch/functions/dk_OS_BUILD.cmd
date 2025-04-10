@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# dk_OS_BUILD()
::#
::#
:dk_OS_BUILD
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=1* delims==" %%A in ('wmic os get BuildNumber /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A" equ "BuildNumber" set "OS_BUILD=%%S"
	))
	
	endlocal & (
		set "OS_BUILD=%OS_BUILD%"
	)
)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_OS_BUILD
	echo OS_BUILD = '%OS_BUILD%'
%endfunction%
