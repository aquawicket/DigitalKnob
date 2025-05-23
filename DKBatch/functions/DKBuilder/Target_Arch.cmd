@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# Target_Arch()
::#
::#	  Target_Arch = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:Target_Arch
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Arch=%~1"
	
	rem ###### GET ######	
	) else (
		echo:
		::if not defined Target_Arch_Cache (%dk_call% Target_Arch_Cache)
		if defined Target_Arch_Cache (
			echo  0^) !Target_Arch_Cache!
			echo:
		)	
		if not defined Host_Arch (%dk_call% dk_Host_Arch)
		echo  1^) !Host_Arch!
		echo  2^) Arm32
		echo  3^) Arm64
		echo  4^) X86
		echo  5^) X86_64
		echo  6^) Go Back
		echo  7^) Exit
		echo:

		%dk_call% dk_keyboardInput
		
		if "!dk_keyboardInput!" equ "0"	(set "Target_Arch=!Target_Arch_Cache!")
		if "!dk_keyboardInput!" equ "1"	(set "Target_Arch=!Host_Arch!")
		if "!dk_keyboardInput!" equ "2" (set "Target_Arch=Arm32")
		if "!dk_keyboardInput!" equ "3" (set "Target_Arch=Arm64")
		if "!dk_keyboardInput!" equ "4" (set "Target_Arch=X86")
		if "!dk_keyboardInput!" equ "5" (set "Target_Arch=X86_64")
		if "!dk_keyboardInput!" equ "6"	(
			endlocal & (
				%dk_call% dk_unset Target_Os
				%return%
			)
		)
		if "!dk_keyboardInput!" equ "7"	(%dk_call% dk_exit 0)
	)
	
	endlocal & (
		set "Target_Arch=%Target_Arch%"
		set "%Target_Arch%_Target=1"
		set "%Target_Arch%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% Target_Arch
	%dk_call% dk_printVar Target_Arch
	%dk_call% dk_printVar %Target_Arch%_Target
	%dk_call% dk_printVar %Target_Arch%
	
	::###### SET ######
	%dk_call% Target_Arch "I686"
	%dk_call% dk_printVar Target_Arch
	%dk_call% dk_printVar %Target_Arch%_Target
	%dk_call% dk_printVar %Target_Arch%
	
%endfunction%