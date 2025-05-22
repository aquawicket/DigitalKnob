@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# Target_Os()
::#
::#	  Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:Target_Os
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Os=%~1"
	
	rem ###### GET ######	
	) else (
		echo:
		
		::if not defined Target_Os_Cache (%dk_call% Target_Os_Cache)
		echo  0^) !Target_Os_Cache!
		echo:
		if not defined Host_Os (%dk_call% dk_Host_Os)
		echo  1^) !Host_Os!
		echo  2^) Android
		echo  3^) Cosmopolitan
		echo  4^) Emscripten
		echo  5^) Ios
		echo  6^) Iossim
		echo  7^) Linux
		echo  8^) Mac
		echo  9^) Raspberry
		echo 10^) Windows
		echo:

		%dk_call% dk_keyboardInput
		
		if "!dk_keyboardInput!" equ "0"		(set "Target_Os=!Target_Os_Cache!")
		if "!dk_keyboardInput!" equ "1"		(set "Target_Os=!Host_Os!")
		if "!dk_keyboardInput!" equ "2" 	(set "Target_Os=Android")
		if "!dk_keyboardInput!" equ "3" 	(set "Target_Os=Cosmopolitan")
		if "!dk_keyboardInput!" equ "4" 	(set "Target_Os=Emscripten")
		if "!dk_keyboardInput!" equ "5" 	(set "Target_Os=Ios")
		if "!dk_keyboardInput!" equ "6" 	(set "Target_Os=Iossim")
		if "!dk_keyboardInput!" equ "7" 	(set "Target_Os=Linux")
		if "!dk_keyboardInput!" equ "8" 	(set "Target_Os=Mac")
		if "!dk_keyboardInput!" equ "9" 	(set "Target_Os=Raspberry")
		if "!dk_keyboardInput!" equ "10"	(set "Target_Os=Windows")
	)
	
	endlocal & (
		set "Target_Os=%Target_Os%"
		set "%Target_Os%_Target=1"
		set "%Target_Os%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% Target_Os
	%dk_call% dk_printVar Target_Os
	%dk_call% dk_printVar %Target_Os%_Target
	%dk_call% dk_printVar %Target_Os%
	
	::###### SET ######
	%dk_call% Target_Os "Windows"
	%dk_call% dk_printVar Target_Os
	%dk_call% dk_printVar %Target_Os%_Target
	%dk_call% dk_printVar %Target_Os%
	
%endfunction%