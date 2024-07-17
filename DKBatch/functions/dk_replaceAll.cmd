@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_replaceAll(input searchValue newValue trn_var)
::#
::#
:dk_replaceAll
	call dk_debugFunc
	if %__ARGC__% neq 4 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
	set "_input_=%~1"
	%if_NDE% call set "_output_=%%_input_:%~2=%~3%%"
	%if_ND% set "_output_=!_input_:%~2=%~3!"
	
	endlocal & set "%4=%_output_%"
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ##########
:DKTEST
	call dk_debugFunc
	
	call dk_set string_var "AZC AZC Zannana Zread"
	call dk_printVar string_var
	call dk_replaceAll "%string_var%" "Z" "B" string_var
	call dk_printVar string_var

	call dk_set varB "C:\path\with\backslashes"
	call dk_printVar varB
	call dk_replaceAll "%varB%" "\" "/" varB
	call dk_printVar varB
goto:eof
