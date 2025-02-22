@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_getPath(path rtn_var)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath
setlocal
	%dk_call% dk_debugFunc 2

    set "_input=%1"
    set "_input=%_input:"=%"
    if "%_input:~-1%"=="\" set "_input=%_input:~0,-1%"
    if "%_input:~-1%"=="/" set "_input=%_input:~0,-1%"
    for %%Z in ("%_input%") do set "_getPath_=%%~pZ"
	if "%_getPath_:~-1%"=="\" set "_getPath_=%_getPath_:~0,-1%"
	if "%_getPath_:~-1%"=="/" set "_getPath_=%_getPath_:~0,-1%"
    endlocal & set "%2=%_getPath_%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getPath DK.cmd path
    %dk_call% dk_echo "path = %path%"
%endfunction%
