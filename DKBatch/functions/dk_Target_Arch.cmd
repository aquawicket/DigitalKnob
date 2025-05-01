@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Target_Arch()
::#
::#	  Target_Arch = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:dk_Target_Arch
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Arch=%~1"
	
	rem ###### GET ######	
	) else (
		echo: 
		if not defined Host_Arch (%dk_call% dk_Host_Arch)
		echo  0^) !Host_Arch!
		echo:
		echo  1^) Arm32
		echo  2^) Arm64
		echo  3^) X86
		echo  4^) X86_64
		echo  5^) NONE
		echo:

		%dk_call% dk_keyboardInput input
		
		if "!input!" equ "0"	(set "Target_Arch=!Host_Arch!")
		if "!input!" equ "1" 	(set "Target_Arch=Arm32")
		if "!input!" equ "2" 	(set "Target_Arch=Arm64")
		if "!input!" equ "3" 	(set "Target_Arch=X86")
		if "!input!" equ "4" 	(set "Target_Arch=X86_64")
		if "!input!" equ "5"	(set "Target_Arch=")
	)
	
	endlocal & (
		set "Target_Arch=%Target_Arch%"
		set "%Target_Arch%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Target_Arch
	%dk_call% dk_printVar Target_Arch
	%dk_call% dk_printVar %Target_Arch%
	
	::###### SET ######
	%dk_call% dk_Target_Arch "I686"
	%dk_call% dk_printVar Target_Arch
	%dk_call% dk_printVar %Target_Arch%
	
%endfunction%