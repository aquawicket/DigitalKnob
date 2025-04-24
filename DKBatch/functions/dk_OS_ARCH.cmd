@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# dk_OS_ARCH()
::#
::#
:dk_OS_ARCH
setlocal
	%dk_call% dk_debugFunc 0

	for /f "tokens=1* delims==" %%A in ('wmic os get OSArchitecture /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A" equ "OSArchitecture" set "OS_ARCH=%%S"
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
