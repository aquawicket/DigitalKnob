@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

set "dk_commandToVariable_PRINT_COMMANDS=1"
::####################################################################
::# dk_commandToVariable(<command> <ret:optional>)
::#
::#		reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 99

	set "_command_=%*"

	::###### _last_arg_ ######
	for %%A in (%*) do set _last_arg_=%%A

	set /a "i=0"
	for /f "usebackq delims=" %%Z in (`%_command_% ^& call echo %%^^errorlevel%%`) do (
		set "dk_commandToVariable[!i!]=%%Z"
		set /a "i+=1"
	)
	%COMSPEC% /c exit /b 0

	::### Final exit_status is stored in last line ###
	set /a "i-=1"
	set /a numLines=i-1
	set /a exit_status = !dk_commandToVariable[%i%]!
	set "dk_commandToVariable[%i%]="								&:: delete the error line from the array
	set "dk_commandToVariable=!dk_commandToVariable[%numLines%]!"

	::### Print the lines of the command ###
	set /a "numLines=numLines-1"
	for /l %%x in (0, 1, %numLines%) do (
		echo !dk_commandToVariable[%%x]!
		set "dk_commandToVariable[%%x]="
	)
	set /a "numLines=numLines+1"
	set "dk_commandToVariable[%numLines%]="							&:: create an empty slot at the end of the array

	::### WARNING ###
	::%dk_call% dk_todo "dk_commandToVariable only returns the last line, or, array item from the command.

	::############### Print call details ###############
	if defined dk_commandToVariable_PRINT_COMMANDS (
		echo #######################################################
		echo ##     command:^> %*
		if defined dk_commandToVariable (echo ##      output: %dk_commandToVariable%)
		echo ## exit_status: %exit_status%
		echo:##
	)
	::##################################################

	::### return the last line from the programs output ###
	endlocal & (
		set "dk_commandToVariable=%dk_commandToVariable%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myCommand ver
	%dk_call% dk_commandToVariable "%myCommand%" RTNVAR
	%dk_call% dk_printVar dk_commandToVariable
	%dk_call% dk_printVar RTNVAR

	%dk_call% dk_set myCommand ""%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_test.exe" "var one" "var two" "var three""
	%dk_call% dk_commandToVariable "%myCommand%"
	%dk_call% dk_printVar dk_commandToVariable
%endfunction%
