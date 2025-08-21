@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# Target_Tuple()
::#
::#	  Target_Tuple = TODO
::#
:Target_Tuple
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Tuple=%~1"
	
	rem ###### GET ######	
	) else if NOT defined Target_Tuple (
		%dk_call% dk_validate Target_Os		"%dk_call% Target_Os"
		%dk_call% dk_validate Target_Arch	"%dk_call% Target_Arch"
		%dk_call% dk_validate Target_Env	"%dk_call% Target_Env"
		set "Target_Tuple=!Target_Os!_!Target_Arch!_!Target_Env!"
	)
	
	endlocal & (
		set "Target_Tuple=%Target_Tuple%"
		set "%Target_Tuple%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% Target_Tuple
	%dk_call% dk_printVar Target_Tuple
	%dk_call% dk_printVar %Target_Tuple%
	
	::###### SET ######
	%dk_call% Target_Tuple "Windows_X86_64_Clang"
	%dk_call% dk_printVar Target_Tuple
	%dk_call% dk_printVar %Target_Tuple%
	
%endfunction%