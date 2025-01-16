@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_commandToVariable(command, args, rtn_var)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable
setlocal
	%dk_call% dk_debugFunc 2 3
 
    set "i=-1"

    for /f "usebackq delims=|" %%Z in (`"%~1" %~2 ^& call echo %%^^ERRORLEVEL%%`) do (
        set /a "i+=1"
        set "line[!i!]=%%Z"
    )
    
::  for /f "tokens=1* delims=   : " %%a in ('"%~1" %~2 & call echo %%ERRORLEVEL%%') do (
::          set /a i+=1
::         	set "line[!i!]=%%a"
::  )

    set /a numLines=i-1
    :: Final errorlevel is stored in last line
    if !line[%i%]! gtr 0 set /a lastline = !line[%i%]! 2>nul && %ComSpec% /c exit %lastline%
    set "line[%i%]="           &:: delete the error line from the array
    
    :: WARNING
    ::%dk_call% dk_todo "dk_commandToVariable only returns the last line, or, array item from the command.
    
    set "lastElement=!line[%numLines%]!"

    :: return the last line from the programs output
    if "%~3" neq "" endlocal & set "%3=%lastElement%" && %return%
    endlocal & set "%2=%lastElement%"
%endfunction%
    
    





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myCommand ver
    %dk_call% dk_commandToVariable "%myCommand%" myVariable
    %dk_call% dk_printVar myVariable
%endfunction%
