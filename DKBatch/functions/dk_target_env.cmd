@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################## dk_Target_Env settings ###########################
if not defined dk_Target_Env_DEFAULT (set "dk_Target_Env_DEFAULT=Clang64")
::#####################################################################
::# dk_Target_Env()
::#
::#	  Target_Env = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
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
		echo  0^) %dk_Target_Env_DEFAULT%
		echo:
		echo  1^) Clang32
		echo  2^) Clang64
		echo  3^) ClangArm64
		echo  4^) Cygwin
		echo  5^) MinGw32
		echo  6^) MinGw64
		echo  7^) Msvc
		echo  8^) Ucrt64
		echo  9^) Wsl
		echo 10^) NONE
		echo:

		%dk_call% dk_keyboardInput input
		
		if "!input!" equ "0"	(set "Target_Env=%dk_Target_Env_DEFAULT%")
		if "!input!" equ "1" 	(set "Target_Env=Clang32")
		if "!input!" equ "2" 	(set "Target_Env=Clang64")
		if "!input!" equ "3" 	(set "Target_Env=ClangArm64")
		if "!input!" equ "4" 	(set "Target_Env=Cygwin")
		if "!input!" equ "5" 	(set "Target_Env=MinGw32")
		if "!input!" equ "6" 	(set "Target_Env=MinGw64")
		if "!input!" equ "7" 	(set "Target_Env=Msvc")
		if "!input!" equ "8" 	(set "Target_Env=Ucrt64")
		if "!input!" equ "9" 	(set "Target_Env=Wsl")
		if "!input!" equ "10"	(set "Target_Env=")
	)
	
	endlocal & (
		set "Target_Env=%Target_Env%"
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
	%dk_call% dk_printVar %Target_Env%
	
	::###### SET ######
	%dk_call% dk_Target_Env "Ucrt64"
	%dk_call% dk_printVar Target_Env
	%dk_call% dk_printVar %Target_Env%
	
%endfunction%