@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##############################################################################
::# dk_hasLabel(file label) -> rtn_var
::# 
::# Test if a string is a dk_hasLabel name
::#
::# @file   - The file to search
::# @name   - The name of the label to search for
::# @rtn_var:   - True if the string is the name of a dk_hasLabel, False if otherwise.
::#
::#
:dk_hasLabel
setlocal
	%dk_call% dk_debugFunc 2 3
 
	findstr /ri /c:"^ *:%~2 " /c:"^ *:%~2$" "%~1" >nul 2>nul && (
        if "%~3" neq "" (endlocal & set "%3=true")
        exit /b 0
    )
    
    if "%~3" neq "" (endlocal & set "%3=false")
    exit /b 1
%endfunction%









::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_hasLabel "%~0" "DKTEST"       && %dk_call% dk_info "'DKTEST' is a label"       || %dk_call% dk_info "'DKTEST' is NOT a label"
%endfunction%
