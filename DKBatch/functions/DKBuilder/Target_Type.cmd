@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#####################################################################
::# Target_Type(rtn_var:Target_Type)
::#
::#
:Target_Type
%setlocal%
	%dk_call% dk_debugFunc 0 1

	rem ###### SET ######
	if "%~1" neq "" (
		endlocal & (
			set "Target_Type=%~1"
			set "!Target_Type!=1"
		)
		
	rem ###### GET ######	
	) else (
			
		%dk_call% dk_echo
		echo 1^) Debug
		echo 2^) Release
		echo 3^) All
		echo 4^) Go Back
		echo 5^) Exit
   
		%dk_call% dk_echo
		%dk_call% dk_echo "Please select a build type."
   
		%dk_call% dk_keyboardInput
		rem %dk_call% dk_keyboardInputTimeout 1 60

		if "!dk_keyboardInput!" equ "1" endlocal & (set "Target_Type=Debug"			& set "!Target_Type!=1"	& %return%)
		if "!dk_keyboardInput!" equ "2" endlocal & (set "Target_Type=Release"		& set "!Target_Type!=1"	& %return%)
		if "!dk_keyboardInput!" equ "3" endlocal & (set "Target_Type=All"			& set "!Target_Type!=1"	& %return%)
		if "!dk_keyboardInput!" equ "4" endlocal & (%dk_call% dk_unset Target_Env	& %return%)
		if "!dk_keyboardInput!" equ "5" (%dk_call% dk_exit 0						& %return%)

		%dk_call% dk_echo !dk_keyboardInput!: invalid selection, please try again
		endlocal & (%dk_call% dk_unset Target_Type)
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::###### GET ######
    %dk_call% Target_Type
	%dk_call% dk_printVar Target_Type
	%dk_call% dk_printVar %Target_Type%
	
	::###### SET ######
	%dk_call% Target_Type "Release"
	%dk_call% dk_printVar Target_Type
	%dk_call% dk_printVar %Target_Type%
%endfunction%
