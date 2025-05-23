@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################## Target_Env settings ###########################
if not defined Target_Env_DEFAULT (set "Target_Env_DEFAULT=Clang")
::#####################################################################
::# Target_Env()
::#
::#	  ::Target_Env = Clang32, Clang64, Cygwin, MinGw32, MinGW64, Msvc, Ucrt64, Wsl
::#	  Target_Env = Clang, Gcc, Msvc
::#
:Target_Env
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		endlocal & (
			set "Target_Env=%~1"
			set "%Target_Env%=1"
			rem set "%Target_Env%_Target=1"
		)
	
	rem ###### GET ######	
	) else (
		echo:
		echo  0^) !Target_Env_Cache!
		echo:
		echo  1^) %Target_Env_DEFAULT%
		echo  2^) Gcc
		echo  3^) Msvc
		echo  4^) Gcc-Ucrt
		echo  5^) Go Back
		echo  6^) Exit
		echo:

		%dk_call% dk_keyboardInput
		if "!dk_keyboardInput!" equ "0"	endlocal & (%dk_call% dk_set 	Target_Env 	%Target_Env_Cache% 		& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "1"	endlocal & (%dk_call% dk_set 	Target_Env 	%Target_Env_DEFAULT% 	& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "2" endlocal & (%dk_call% dk_set 	Target_Env 	Gcc						& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "3" endlocal & (%dk_call% dk_set 	Target_Env 	Msvc					& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "4" endlocal & (%dk_call% dk_set	Target_Env 	Ucrt					& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "5"	endlocal & (%dk_call% dk_unset	Target_Arch							& set "!Target_Env!=1"	&	%return%)
		if "!dk_keyboardInput!" equ "6"	endlocal & (%dk_call% dk_exit 	0											 )
										endlocal & (%dk_call% dk_unset 	Target_Env	& %dk_call% dk_unset %Target_Env%)
		%dk_call% dk_echo !dk_keyboardInput!: invalid selection, please try again
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% Target_Env
	%dk_call% dk_printVar Target_Env
	%dk_call% dk_printVar %Target_Env%_Target
	%dk_call% dk_printVar %Target_Env%
	
	::###### SET ######
	%dk_call% Target_Env "MyEnvironment"
	%dk_call% dk_printVar Target_Env
	%dk_call% dk_printVar %Target_Env%_Target
	%dk_call% dk_printVar %Target_Env%
	
%endfunction%