<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_realpath(path, rtn_var)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_realpath(<pathname>, <rtn_var>:optional)
>>>>>>> Development
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#
:dk_realpath
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 2
    
    set "_input_=%~1"
    set "_input_=%_input_:"=%"
    if [%_input_:~-1%] == [\] set "_input_=%_input_:~0,-1%"
    if [%_input_:~-1%] == [/] set "_input_=%_input_:~0,-1%"
    for %%Z in ("%_input_%") do set "_realpath_=%%~fZ"
    endlocal & set "%~2=%_realpath_%"
=======
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 1 2
    
	set "pathname=%1"
    set "pathname=%pathname:"=%"
	
    for %%A in ("%pathname%") do (set "dk_realpath=%%~fA")
	if "%dk_realpath:~-1%" equ "\" (set "dk_realpath=%dk_realpath:~0,-1%")
	
	%dk_call% dk_readlink "%dk_realpath:\=/%" dk_realpath
	
    endlocal & (
		set "dk_realpath=%dk_realpath:\=/%"
		if "%~2" neq "" (set "%~2=%dk_realpath:\=/%")
	)
	
	if exist "%dk_realpath%" exit /b 0
	exit /b 1
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_realpath "%myPath%" realpath
    %dk_call% dk_printVar realpath
=======
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
	
	%dk_call% dk_set myPath "Test"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
	
	%dk_call% dk_set myPath "../functions"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
	
	%dk_call% dk_set myPath "C:/Users/Administrator/Desktop/DKBuilder.cmd"
	%dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
	
	%dk_call% dk_set myPath "C:/Users/Administrator/Desktop/digitalknob"
	%dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
	
	%dk_call% dk_set myPath "NonExistent"
    %dk_call% dk_realpath "%myPath%"
    %dk_call% dk_printVar dk_realpath
>>>>>>> Development
%endfunction%
