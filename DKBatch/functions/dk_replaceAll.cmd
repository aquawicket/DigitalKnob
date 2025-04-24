@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_replaceAll(<input>, <searchValue>, <newValue>, <rtn_var>:optional)
::#
::#
:dk_replaceAll
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 3 4

    set "_input_=%~1"
    set "dk_replaceAll=!_input_:%~2=%~3!"
	
	endlocal & (
		set "dk_replaceAll=%dk_replaceAll%"
		if "%~4" neq "" (set "%~4=%dk_replaceAll%")
	)
		
	::endlocal & (
	::	%dk_call% dk_set dk_replaceAll "%dk_replaceAll%"
	::	if "%~4" neq "" (%dk_call% dk_set %~4 "%dk_replaceAll%")
	::)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ########
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	:: replaceAll with result in <dk_replaceAll> variable
    %dk_call% dk_set string_var "AZC AZC Zannana Zread"
    %dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "Z" "B"
    %dk_call% dk_printVar dk_replaceAll

	:: replaceAll with result in same variable
	%dk_call% dk_echo
	%dk_call% dk_set string_var "AZC AZC Zannana Zread"
    %dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "Z" "B" string_var
    %dk_call% dk_printVar string_var
	
	:: replace back slashes's with forward slashes's
	%dk_call% dk_echo
    %dk_call% dk_set string_var "C:\path\with\backslashes"
	%dk_call% dk_printVar string_var
    %dk_call% dk_replaceAll "%string_var%" "\" "/"
	%dk_call% dk_printVar dk_replaceAll
	
	:: replace _'s with <space>'s
	%dk_call% dk_echo
	%dk_call% dk_set string_var "dk_info('test dk_info message')"
	%dk_call% dk_printVar string_var
	%dk_call% dk_replaceAll "%string_var%" "_" " "
	%dk_call% dk_printVar dk_replaceAll
%endfunction%
