@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Target_Tuple()
::#
::#	  Target_Tuple = TODO
::#
:dk_Target_Tuple
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Tuple=%~1"
	
	rem ###### GET ######	
	) else if not defined Target_Tuple (
		%dk_call% dk_validate Target_Os		"%dk_call% dk_Target_Os"
		%dk_call% dk_validate Target_Arch	"%dk_call% dk_Target_Arch"
		%dk_call% dk_validate Target_Env	"%dk_call% dk_Target_Env"
		set "Target_Tuple=!Target_Os!_!Target_Arch!_!Target_Env!"
	)
	
	endlocal & (
		set "Target_Tuple=%Target_Tuple%"
		set "%Target_Tuple%_Target=1"
		set "%Target_Tuple%=1"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::###### GET ######
    %dk_call% dk_Target_Tuple
	%dk_call% dk_printVar Target_Tuple
	%dk_call% dk_printVar %Target_Tuple%_Target
	%dk_call% dk_printVar %Target_Tuple%
	
	::###### SET ######
	%dk_call% dk_Target_Tuple "Windows_X86_64_Clang"
	%dk_call% dk_printVar Target_Tuple
	%dk_call% dk_printVar %Target_Tuple%_Target
	%dk_call% dk_printVar %Target_Tuple%
	
%endfunction%