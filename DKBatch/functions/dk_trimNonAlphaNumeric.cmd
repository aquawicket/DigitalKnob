@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_trimNonAlphaNumeric(string rtn_var)
::#
::#
:dk_trimNonAlphaNumeric
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "_input_=%~1"
	set "dk_trimNonAlphaNumeric="
	set "map=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

	::echo %_input_:~0,1% 	&::=a
	::echo %_input_:~1%   	&::=bcd
	::echo %_input_:~-1%  	&::=d
	::echo %_input_:~0,-1% 	&::abc
	:dk_front_loop
		if NOT defined _input_ (goto:dk_front_loop_end)
		for /F "delims=*~ eol=*" %%C in ("%_input_:~0,1%") do (
			if "!map:%%C=!" neq "%map%" (set "continue=1")
			if defined continue (
				set "front=!front!%%C"
			) else (
				set "front=!front!"
			)
		)
		set "_input_=%_input_:~1%"
		goto:dk_front_loop
	:dk_front_loop_end
	

	set "_input_=%front%"
	set "continue="
	:dk_back_loop
		if NOT defined _input_ (goto:dk_back_loop_end)
		for /F "delims=*~ eol=*" %%C in ("%_input_:~-1%") do (
			if "!map:%%C=!" neq "%map%" (set "continue=1")
			if defined continue (
				set "dk_trimNonAlphaNumeric=%%C!dk_trimNonAlphaNumeric!"
			) else (
				set "dk_trimNonAlphaNumeric=!dk_trimNonAlphaNumeric!"
			)
		)
		set "_input_=%_input_:~0,-1%"
		goto:dk_back_loop
	:dk_back_loop_end
	

	::###### output ######
	endlocal & (
		set "dk_trimNonAlphaNumeric=%dk_trimNonAlphaNumeric%"
		if "%~2" neq "" (
			set "%~2=%dk_trimNonAlphaNumeric%"
		) else (
			echo %dk_trimNonAlphaNumeric%
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "myVar=--0.2.134Beta--"
	%dk_call% dk_trimNonAlphaNumeric "%myVar%"
	%dk_call% dk_printVar dk_trimNonAlphaNumeric

	::%dk_call% dk_set myVar "--0.2.134Beta"
	::%dk_call% dk_trimNonAlphaNumeric "%myVar%" cIdentifier
	::%dk_call% dk_printVar dk_trimNonAlphaNumeric
	::%dk_call% dk_printVar cIdentifier
%endfunction%
