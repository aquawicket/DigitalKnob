@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getDrive(<pathname>, <rtn_var>:optional)
::#
::#
:dk_getDrive
setlocal
	%dk_call% dk_debugFunc 2    

	set "pathname=%1"
    set "pathname=%pathname:"=%"
	
::  if "%pathname:~-1%"=="\" set "pathname=%pathname:~0,-1%"
::  if "%pathname:~-1%"=="/" set "pathname=%pathname:~0,-1%"

    for %%Z in ("%pathname%") do set "dk_getDrive=%%~dZ"
	
    endlocal & (
		set "dk_getDrive=%dk_getDrive%"
		if "%2" neq "" set "%2=%dk_getDrive%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getDrive "%myPath%" drive
    %dk_call% dk_printVar drive
	
	%dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getDrive "%myPath%" drive
    %dk_call% dk_printVar drive
%endfunction%
