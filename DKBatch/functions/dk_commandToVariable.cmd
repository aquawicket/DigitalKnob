@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_commandToVariable(command, rtn_var)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
::	for /f "usebackq delims=|" %%f in (`%~1`) do (
::		set "%2=%%f"
::  )
	::setlocal
	set "command=%~1"
	set i=-1
	for /f "usebackq delims=|" %%Z in (`%command% ^& call echo %%^^ERRORLEVEL%%`) do (
		set /A i+=1
		%if_NDE% call set "line[%%i%%]=%%a"
		%if_DE% set "line[!i!]=%%Z"
	)
	set /A numLines=i-1
	:: Final errorlevel is stored in last line
	%if_DE% if !line[%i%]! gtr 0 set /a lastline = !line[%i%]! 2>nul && cmd /c exit %lastline%
	set "line[%i%]="           &:: delete the error line from the array
	
	call dk_fixme "dk_commandToVariable only returns the last element of an array"
	%if_NDE% endlocal & call set "%2=%line[%%numLines%%]%"    &:: return the last line from the programs output
	%if_DE% endlocal & set "%2=!line[%numLines%]!"    		  &:: return the last line from the programs output
)

goto:eof
	
	





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_set myCommand ver
	call dk_commandToVariable "%myCommand%" myVariable
	call dk_printVar myVariable
goto:eof
