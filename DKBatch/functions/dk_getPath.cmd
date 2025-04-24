<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getPath(path rtn_var)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_getPath(<path>, <rtn_var>:optional)
>>>>>>> Development
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal
 
    set "_input=%1"
    set "_input=%_input:"=%"
    if [%_input:~-1%] == [\] set "_input=%_input:~0,-1%"
    if [%_input:~-1%] == [/] set "_input=%_input:~0,-1%"
    for %%Z in ("%_input%") do set "_getPath_=%%~pZ"
	if [%_getPath_:~-1%] == [\] set "_getPath_=%_getPath_:~0,-1%"
	if [%_getPath_:~-1%] == [/] set "_getPath_=%_getPath_:~0,-1%"
    endlocal & set "%2=%_getPath_%"
=======
setlocal
	%dk_call% dk_debugFunc 1 2

    set "_input=%1"
    set "_input=%_input:"=%"
	set "_input=%_input:/=\%"
    if "%_input:~-1%" equ "\" (set "_input=%_input:~0,-1%")
    for %%Z in ("%_input%") do (set "dk_getPath=%%~pZ")
	if "%dk_getPath:~-1%" equ "\" (set "dk_getPath=%dk_getPath:~0,-1%")
	
    endlocal & (
		set "dk_getPath=%dk_getPath:\=/%"
		if "%~2" neq "" (set "%~2=%dk_getPath:\=/%")
	)
>>>>>>> Development
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getPath DK.cmd path
    %dk_call% dk_echo "path = %path%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getPath "%myPath%"
    %dk_call% dk_printVar dk_getPath
>>>>>>> Development
%endfunction%
