@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_commandToVariable(command, args, rtn_var)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
	call dk_debugFunc 2 3
	
	setlocal
	set i=-1

	for /f "usebackq delims=|" %%Z in (`"%~1" %~2 ^& call echo %%^^ERRORLEVEL%%`) do (
		set /A i+=1
		if "!!" equ "" set "line[!i!]=%%Z"
		if "!!" neq "" call set "line[%%i%%]=%%Z"
	)

	set /A numLines=i-1
	:: Final errorlevel is stored in last line
	if "!!" equ "" if !line[%i%]! gtr 0 set /a lastline = !line[%i%]! 2>nul && %ComSpec% /c exit %lastline%
	if "!!" neq "" call set /a lastline = %line[%%i%%]% 2>nul && %ComSpec% /c exit %lastline%
	set "line[%i%]="           &:: delete the error line from the array
	
	:: WARNING
	%dk_call% dk_warning "dk_commandToVariable only returns the last line, or, array item from the command.
	
	if "!!" equ "" set "lastElement=!line[%numLines%]!"
	if "!!" neq "" call set "lastElement=%%line[%numLines%]%%"

	:: return the last line from the programs output
	if "%~3" neq "" endlocal & set "%3=%lastElement%" && goto:eof
	endlocal & set "%2=%lastElement%"
goto:eof
	
	





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_set myCommand ver
	%dk_call% dk_commandToVariable "%myCommand%" myVariable
	%dk_call% dk_printVar myVariable
goto:eof
