@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################## dk_Target_Env settings ###########################
if not defined dk_Target_Env_DEFAULT (set "dk_Target_Env_DEFAULT=Clang")
::#####################################################################
::# dk_Target_Env()
::#
::#	  ::Target_Env = Clang32, Clang64, Cygwin, MinGw32, MinGW64, Msvc, Ucrt64, Wsl
::#	  Target_Env = Clang, Gcc, Msvc
::#
:dk_Target_Env
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Env=%~1"
	
	rem ###### GET ######	
	) else (
		echo:
		echo  0^) !Target_Env_Cache!
		echo:
		echo  1^) %dk_Target_Env_DEFAULT%
		echo  2^) Clang
		echo  3^) Gcc
		echo  4^) Msvc
		echo:

		%dk_call% dk_keyboardInput input
		if "!input!" equ "0"	(set "Target_Env=%Target_Env_Cache%")
		if "!input!" equ "1"	(set "Target_Env=%dk_Target_Env_DEFAULT%")
		if "!input!" equ "2" 	(set "Target_Env=Clang")
		if "!input!" equ "3" 	(set "Target_Env=Gcc")
		if "!input!" equ "4" 	(set "Target_Env=Msvc")
	)
	
	endlocal & (
		set "Target_Env=%Target_Env%"
		set "%Target_Env%_Target=1"
		set "%Target_Env%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Target_Env
	%dk_call% dk_printVar Target_Env
	%dk_call% dk_printVar %Target_Env%_Target
	%dk_call% dk_printVar %Target_Env%
	
	::###### SET ######
	%dk_call% dk_Target_Env "Clang"
	%dk_call% dk_printVar Target_Env
	%dk_call% dk_printVar %Target_Env%_Target
	%dk_call% dk_printVar %Target_Env%
	
%endfunction%