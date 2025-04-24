<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_getFileTime(path rtn_var)
::#
::#
:dk_getFileTime
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal
 
    set _input=%1
    set _input=%_input:"=%
    if [%_input:~-1%] == [\] set _input=%_input:~0,-1%
    if [%_input:~-1%] == [/] set _input=%_input:~0,-1%
    endlocal & for %%Z in ("%_input%") do set "%2=%%~tZ"
=======
setlocal
	%dk_call% dk_debugFunc 2

	set _input=%1
	set _input=%_input:"=%
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	endlocal & for %%Z in ("%_input%") do set "%2=%%~tZ"
>>>>>>> Development
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getFileTime "%myPath%" fileTime
    %dk_call% dk_printVar fileTime
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getFileTime "%myPath%" fileTime
	%dk_call% dk_printVar fileTime
>>>>>>> Development
%endfunction%
