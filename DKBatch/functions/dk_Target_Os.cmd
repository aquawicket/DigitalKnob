@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Target_Os()
::#
::#	  Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
::#
:dk_Target_Os
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Os=%~1"
	
	rem ###### GET ######	
	) else (
		echo: 
		
		if not defined Host_Os (%dk_call% dk_Host_Os)
		echo  0^) !Host_Os!
		echo:
		echo  1^) Android
		echo  2^) Cosmopolitan
		echo  3^) Emscripten
		echo  4^) Ios
		echo  5^) Iossim
		echo  6^) Linux
		echo  7^) Mac
		echo  8^) Raspberry
		echo  9^) Windows
		echo 10^) NONE
		echo:

		%dk_call% dk_keyboardInput input
		
		if "!input!" equ "0"	(set "Target_Os=!Host_Os!")
		if "!input!" equ "1" 	(set "Target_Os=Android")
		if "!input!" equ "2" 	(set "Target_Os=Cosmopolitan")
		if "!input!" equ "3" 	(set "Target_Os=Emscripten")
		if "!input!" equ "4" 	(set "Target_Os=Ios")
		if "!input!" equ "5" 	(set "Target_Os=Iossim")
		if "!input!" equ "6" 	(set "Target_Os=Linux")
		if "!input!" equ "7" 	(set "Target_Os=Mac")
		if "!input!" equ "8" 	(set "Target_Os=Raspberry")
		if "!input!" equ "9" 	(set "Target_Os=Windows")
		if "!input!" equ "10"	(set "Target_Os=")
	)
	
	endlocal & (
		set "Target_Os=%Target_Os%"
		set "%Target_Os%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Target_Os
	%dk_call% dk_printVar Target_Os
	%dk_call% dk_printVar %Target_Os%
	
	::###### SET ######
	%dk_call% dk_Target_Os "Windows"
	%dk_call% dk_printVar Target_Os
	%dk_call% dk_printVar %Target_Os%
	
%endfunction%