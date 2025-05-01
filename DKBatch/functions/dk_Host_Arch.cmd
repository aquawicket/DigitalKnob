@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Host_Arch()
::#
::#	  Host_Arch = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:dk_Host_Arch
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Arch=%~1"
	
	rem ###### GET ######	
	) else (
		if "%PROCESSOR_ARCHITECTURE%" equ "x86"   (set "Host_Arch=X86")
		if "%PROCESSOR_ARCHITECTURE%" equ "AMD64" (set "Host_Arch=X86_64")
		if "%PROCESSOR_ARCHITECTURE%" equ "IA64"  (set "Host_Arch=X86_64")
		if "%PROCESSOR_ARCHITECTURE%" equ "EM64T" (set "Host_Arch=X86_64")
		if "%PROCESSOR_ARCHITECTURE%" equ "ARM64" (set "Host_Arch=Arm64")
	)
	
	endlocal & (
		set "Host_Arch=%Host_Arch%"
		set "%Host_Arch%_Host=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Host_Arch
	%dk_call% dk_printVar Host_Arch
	%dk_call% dk_printVar %Host_Arch%_Host
	
	::###### SET ######
	%dk_call% dk_Host_Arch "I686"
	%dk_call% dk_printVar Host_Arch
	%dk_call% dk_printVar %Host_Arch%_Host
	
%endfunction%