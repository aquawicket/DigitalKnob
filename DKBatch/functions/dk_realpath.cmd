@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_realpath(<pathname>, <rtn_var>:optional)
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#
:dk_realpath
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 2
    
	set "pathname=%1"
    set "pathname=%pathname:"=%"
	
	if not "X!pathname:/=!X"=="X%pathname%X" (set fslashes=1)

::  if "%pathname:~-1%"=="\" (set pathname=%pathname:~0,-1%)
::  if "%pathname:~-1%"=="/" (set pathname=%pathname:~0,-1%)

    for %%Z in ("%pathname%") do set "dk_realpath=%%~fZ"
	if "%dk_realpath:~-1%"=="\" set "dk_realpath=%dk_realpath:~0,-1%"
	
::	if defined fslashes (set dk_realpath=%dk_realpath:\=/%)
::	%dk_call% dk_assertPath %dk_realpath%
	
    endlocal & (
		set "dk_realpath=%dk_realpath%"
		if "%2" neq "" set "%2=%dk_realpath%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_realpath "%myPath%" realpath
    %dk_call% dk_printVar realpath
	
	%dk_call% dk_set myPath "C:/Windows/System32/cmd.exe"
    %dk_call% dk_realpath "%myPath%" realpath
    %dk_call% dk_printVar realpath
%endfunction%
