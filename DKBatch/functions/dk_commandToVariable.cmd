@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

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

	::### set dk_commandToVariable[] array ###
	set /a "i=0"
	for /f "usebackq delims=" %%Z in (`%_command_% ^& call echo %%^^errorlevel%%`) do (
		set "dk_commandToVariable[!i!]=%%Z"
		set /a "i+=1"
	)
	%COMSPEC% /c exit /b 0   &::NOTE:  what is this doing, why is it needed?

	::### set dk_commandToVariable_exit_status ###
	set /a "exit_status_line=i-1"
	::set /a "dk_commandToVariable[%exit_status_line%]=13"   &::DEBUG: Test error return
	set /a "dk_commandToVariable_exit_status=!dk_commandToVariable[%exit_status_line%]!"
	set /a "dk_commandToVariable[%exit_status_line%]="   &:: clear the errorline from the array
	
	::### set dk_commandToVariable ###
	set /a "last_output_line=i-2"
	set "dk_commandToVariable=!dk_commandToVariable[%last_output_line%]!"

	::############### Print call details ###############
	if defined dk_commandToVariable_PRINT_COMMANDS (
		echo #######################################################
		echo ##                          command: = '%*'
		echo ##
		for /l %%x in (0, 1, %exit_status_line%) do (
			if defined dk_commandToVariable[%%x] (
		echo ##        dk_commandToVariable[%%x]: = !dk_commandToVariable[%%x]!
			)
		)
		echo ##             dk_commandToVariable: = !dk_commandToVariable!
		echo ## dk_commandToVariable_exit_status: = %dk_commandToVariable_exit_status%
		echo ##
	)
	::##################################################

	::### Return the array to the calling scope ###
	set "currentScope=1"
	for /F "delims=" %%b in ('set dk_commandToVariable') do (
		if defined currentScope endlocal
		set "%%b"
	)
exit /b %dk_commandToVariable_exit_status%
::%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

::	%dk_call% dk_set myCommand ver
::	%dk_call% dk_commandToVariable "%myCommand%" RTNVAR
::	%dk_call% dk_printVar dk_commandToVariable
::	%dk_call% dk_printVar RTNVAR

::	%dk_call% dk_set myCommand ""%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_test.exe" "var one" "var two" "var three""
::	%dk_call% dk_commandToVariable "%myCommand%"
::	%dk_call% dk_printVar dk_commandToVariable
	
	%dk_call% dk_validate ADB_EXE "%dk_call% ANDROID::dk_ADB_EXE"
	%dk_call% dk_set myCommand ""%ADB_EXE%" shell pm list packages" &::-f string
	%dk_call% dk_commandToVariable "%myCommand%"
	%dk_call% dk_printVar dk_commandToVariable
	%dk_call% dk_echo "dk_commandToVariable = %dk_commandToVariable%"
	%dk_call% dk_echo "dk_commandToVariable_exit_status = %dk_commandToVariable_exit_status%"

%endfunction%
