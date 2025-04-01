@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_OS_ARCH()
::#
::#
:dk_OS_ARCH
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=1* delims==" %%A in ('wmic os get OSArchitecture /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A"=="OSArchitecture" set "OS_ARCH=%%S"
	))
	
	endlocal & (
		set "OS_ARCH=%OS_ARCH%"
	)
)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_OS_ARCH
	echo OS_ARCH = '%OS_ARCH%'
%endfunction%
