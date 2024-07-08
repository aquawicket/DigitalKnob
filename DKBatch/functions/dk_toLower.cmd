@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_toLower(string rtn_var)
::#
::#
:dk_toLower
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal EnableDelayedExpansion
		call dk_set _input_ %~1
		call dk_set _UCASE ABCDEFGHIJKLMNOPQRSTUVWXYZ
		call dk_set _LCASE abcdefghijklmnopqrstuvwxyz
		
		for /l %%a in (0,1,25) do (
			call set "_FROM_=%%_UCASE:~%%a,1%%
			call set "_TO_=%%_LCASE:~%%a,1%%
			call set "_input_=%%_input_:!_FROM_!=!_TO_!%%
			call set "_output_=!_input_!"
		)	
	endlocal & call dk_set %2 %_output_%
goto:eof



::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	:: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	call dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	call dk_toLower "%myVar%" myLowerCaseVar
	call dk_printVar myLowercaseVar
goto:eof
