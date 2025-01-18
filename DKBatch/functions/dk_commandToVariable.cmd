@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_commandToVariable(command, args, rtn_var)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 3
 
    set /a "i=0"
    for /f "usebackq delims=" %%Z in (`"%~1" %~2 ^& call echo %%^^errorlevel%%`) do (
        set "line[!i!]=%%Z"
		echo !i! = %%Z
		set /a "i+=1"
    )
	%COMSPEC% /c exit /b 0
	:: Final errorlevel is stored in last line
	set /a "i-=1"
	set /a numLines=i-1
	set /a errorcode = !line[%i%]!
    set "line[%i%]="           &:: delete the error line from the array
    set "lastline=!line[%numLines%]!"


	
    :: WARNING
    ::%dk_call% dk_todo "dk_commandToVariable only returns the last line, or, array item from the command.

	::############### Print call details ###############
					echo ###############################
	if "%~3" neq "" echo ## command:^> '%~1 %~2'
	if "%~3" equ "" echo ## command:^> '%~1'
					echo ##  output: %lastline%
					echo ## rtncode: %errorcode%
					echo:##
	::##################################################

	
    :: return the last line from the programs output
    if "%~3" neq "" endlocal & set "%3=%lastline%" && %return%
    endlocal & set "%2=%lastline%"
%endfunction%
    
    





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myCommand ver
    %dk_call% dk_commandToVariable "%myCommand%" myVariable
    %dk_call% dk_printVar myVariable
%endfunction%
